management_groups = {
    root = {
        name = "root"
        subscriptions = ["rootsub"]
        children = {
            child1 = {
                name = "tree1child1"
                subscriptions = ["child1sub"]
                children = {
                    child1subchild = {
                    name = "child1subchild"
                    subscriptions = ["child1subchildsub"]
                    }
            }
            child2 = {
                name = "tree1child2"
                subscriptions = ["child2sub"]
            }
            child3 = {
                name = "tree1child3"
                subscriptions = ["child2sub"]
            }
            }
        }
    }
}