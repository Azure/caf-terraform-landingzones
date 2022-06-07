package main

import (
	"context"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"

	"github.com/google/go-github/v45/github"
	"golang.org/x/oauth2"
)

type Config struct {
	runnerPrefix string
	org          string
	token        string
	numRunners   int
}

func GetRunnersToRemove(client *github.Client, config Config) (map[int64]*github.Runner, error) {
	var allRunners []*github.Runner
	runnersToRemove := make(map[int64]*github.Runner)
	opt := &github.ListOptions{Page: 1, PerPage: 30}
	ctx := context.Background()

	for {
		runners, resp, err := client.Actions.ListOrganizationRunners(ctx, config.org, opt)
		if err != nil {
			return nil, err
		}
		allRunners = append(allRunners, runners.Runners...)
		for i := 1; i <= config.numRunners; i++ {
			runnerName := strings.Join([]string{config.runnerPrefix, strconv.Itoa(i)}, "-")
			for _, runner := range allRunners {
				if *runner.Name == runnerName {
					runnersToRemove[*runner.ID] = runner
				}
			}
		}
		if resp.NextPage == 0 {
			break
		}
		opt.Page = resp.NextPage
	}

	return runnersToRemove, nil
}

func GetEnvVars() (Config, error) {
	runnerPrefix := os.Getenv("GH_RUNNER_PREFIX")
	if runnerPrefix == "" {
		return Config{}, errors.New("environment variable 'GH_RUNNER_PREFIX' required")
	}

	org := os.Getenv("GH_ORG")
	if org == "" {
		return Config{}, errors.New("environment variable 'GH_ORG' required")
	}

	token := os.Getenv("GH_TOKEN")
	if token == "" {
		return Config{}, errors.New("environment variable 'GH_TOKEN' required")
	}

	s_numRunners := os.Getenv("GH_NUM_RUNNERS")
	if s_numRunners == "" {
		return Config{}, errors.New("environment variable 'GH_NUM_RUNNERS' required")
	}
	numRunners, err := strconv.Atoi(s_numRunners)
	if err != nil {
		return Config{}, err
	}

	return Config{runnerPrefix, org, token, numRunners}, nil
}

func main() {
	config, err := GetEnvVars()
	if err != nil {
		fmt.Printf("error fetching config: %v\n", err)
		os.Exit(1)
	}

	// create a github client
	ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: config.token})
	tc := oauth2.NewClient(context.Background(), ts)
	client := github.NewClient(tc)

	// find info about the runners to remove from the API
	runnersToRemove, err := GetRunnersToRemove(client, config)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	if len(runnersToRemove) != config.numRunners {
		if len(runnersToRemove) == 0 {
			fmt.Printf("error: we were asked to remove %d runners but couldn't find any of them\n",
				config.numRunners)
		} else {
			fmt.Printf("error: we were asked to remove %d runners but could only find the following %d:\n",
				config.numRunners, len(runnersToRemove))
			for k, v := range runnersToRemove {
				fmt.Printf("ID: %d, Name: %s\n", k, *v.Name)
			}
		}
		os.Exit(1)
	}

	// remove them from the org
	for k, v := range runnersToRemove {
		fmt.Printf("Removing runner %s\n", *v.Name)
		_, err := client.Actions.RemoveOrganizationRunner(context.Background(), config.org, k)
		if err != nil {
			fmt.Printf("error removing runner %s: %v\n", *v.Name, err)
			os.Exit(1)
		}
	}
}
