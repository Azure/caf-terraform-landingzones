  {
    "lenses": {
      "0": {
        "order": 0,
        "parts": {
          "0": {
            "position": {
              "x": 0,
              "y": 0,
              "colSpan": 16,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "settings": {
                    "content": "",
                    "title": "Edge Monitoring ",
                    "subtitle": ""
                  }
                }
              }
            }
          },
          "1": {
            "position": {
              "x": 0,
              "y": 1,
              "colSpan": 8,
              "rowSpan": 6
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${fw_id}"
                          },
                          "name": "ApplicationRuleHit",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/azurefirewalls",
                          "metricVisualization": {
                            "displayName": "Application rules hit count"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${fw_id}"
                          },
                          "name": "DataProcessed",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/azurefirewalls",
                          "metricVisualization": {
                            "displayName": "Data processed"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${fw_id}"
                          },
                          "name": "FirewallHealth",
                          "aggregationType": 4,
                          "namespace": "microsoft.network/azurefirewalls",
                          "metricVisualization": {
                            "displayName": "Firewall health state"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${fw_id}"
                          },
                          "name": "NetworkRuleHit",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/azurefirewalls",
                          "metricVisualization": {
                            "displayName": "Network rules hit count"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${fw_id}"
                          },
                          "name": "SNATPortUtilization",
                          "aggregationType": 4,
                          "namespace": "microsoft.network/azurefirewalls",
                          "metricVisualization": {
                            "displayName": "SNAT port utilization"
                          }
                        }
                      ],
                      "title": "Sum Application rules hit count, Sum Data processed, and 3 other metrics for az-fw-arnaud",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        }
                      }
                    },
                    "version": 2
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${fw_id}"
                          },
                          "name": "ApplicationRuleHit",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/azurefirewalls",
                          "metricVisualization": {
                            "displayName": "Application rules hit count"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${fw_id}"
                          },
                          "name": "DataProcessed",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/azurefirewalls",
                          "metricVisualization": {
                            "displayName": "Data processed"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${fw_id}"
                          },
                          "name": "FirewallHealth",
                          "aggregationType": 4,
                          "namespace": "microsoft.network/azurefirewalls",
                          "metricVisualization": {
                            "displayName": "Firewall health state"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${fw_id}"
                          },
                          "name": "NetworkRuleHit",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/azurefirewalls",
                          "metricVisualization": {
                            "displayName": "Network rules hit count"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${fw_id}"
                          },
                          "name": "SNATPortUtilization",
                          "aggregationType": 4,
                          "namespace": "microsoft.network/azurefirewalls",
                          "metricVisualization": {
                            "displayName": "SNAT port utilization"
                          }
                        }
                      ],
                      "title": "Azure Firewall - Egress Overview",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    },
                    "version": 2
                  }
                }
              }
            }
          },
          "2": {
            "position": {
              "x": 8,
              "y": 1,
              "colSpan": 8,
              "rowSpan": 6
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "ByteCount",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Byte Count"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "PacketCount",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Packet Count"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "SynCount",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "SYN Count"
                          }
                        }
                      ],
                      "title": "Public IP - Egress Overview",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        }
                      }
                    },
                    "version": 2
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "ByteCount",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Byte Count"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "PacketCount",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Packet Count"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "SynCount",
                          "aggregationType": 1,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "SYN Count"
                          }
                        }
                      ],
                      "title": "Public IP - Egress Overview",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    },
                    "version": 2
                  }
                }
              }
            }
          },
          "3": {
            "position": {
              "x": 0,
              "y": 7,
              "colSpan": 8,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "BytesInDDoS",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Inbound bytes DDoS"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "BytesDroppedDDoS",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Inbound bytes dropped DDoS"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "TCPBytesInDDoS",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Inbound TCP bytes DDoS"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "DDoSTriggerSYNPackets",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Inbound SYN packets to trigger DDoS mitigation"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "UDPBytesInDDoS",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Inbound UDP bytes DDoS"
                          }
                        }
                      ],
                      "title": "DDoS Statistics",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        }
                      }
                    },
                    "version": 2
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "BytesInDDoS",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Inbound bytes DDoS"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "BytesDroppedDDoS",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Inbound bytes dropped DDoS"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "TCPBytesInDDoS",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Inbound TCP bytes DDoS"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "DDoSTriggerSYNPackets",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Inbound SYN packets to trigger DDoS mitigation"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "UDPBytesInDDoS",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Inbound UDP bytes DDoS"
                          }
                        }
                      ],
                      "title": "IP address - Egress - DDoS Overview",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    },
                    "version": 2
                  }
                }
              }
            }
          },
          "4": {
            "position": {
              "x": 8,
              "y": 7,
              "colSpan": 8,
              "rowSpan": 5
            },
            "metadata": {
              "inputs": [
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "IfUnderDDoSAttack",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Under DDoS attack or not"
                          }
                        }
                      ],
                      "title": "Max Under DDoS attack or not for arnaud-pip-egress",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 1,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        }
                      }
                    },
                    "version": 2
                  },
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "${pip_id}"
                          },
                          "name": "IfUnderDDoSAttack",
                          "aggregationType": 3,
                          "namespace": "microsoft.network/publicipaddresses",
                          "metricVisualization": {
                            "displayName": "Under DDoS attack or not"
                          }
                        }
                      ],
                      "title": "DDoS Attack Detected",
                      "titleKind": 2,
                      "visualization": {
                        "chartType": 1,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    },
                    "version": 2
                  }
                }
              }
            }
          },
          "5": {
            "position": {
              "x": 0,
              "y": 12,
              "colSpan": 16,
              "rowSpan": 1
            },
            "metadata": {
              "inputs": [],
              "type": "Extension/HubsExtension/PartType/MarkdownPart",
              "settings": {
                "content": {
                  "settings": {
                    "content": "",
                    "title": "Virtual Network Monitoring",
                    "subtitle": ""
                  }
                }
              }
            }
          }
        }
      }
    },
    "metadata": {
      "model": {
        "timeRange": {
          "value": {
            "relative": {
              "duration": 24,
              "timeUnit": 1
            }
          },
          "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        },
        "filterLocale": {
          "value": "en-us"
        },
        "filters": {
          "value": {
            "MsPortalFx_TimeRange": {
              "model": {
                "format": "utc",
                "granularity": "auto",
                "relative": "24h"
              },
              "displayCache": {
                "name": "UTC Time",
                "value": "Past 24 hours"
              },
              "filteredPartIds": [
                "StartboardPart-MonitorChartPart-1bd243d6-36d8-4329-8ed0-02aa14c243e3",
                "StartboardPart-MonitorChartPart-1bd243d6-36d8-4329-8ed0-02aa14c245fc",
                "StartboardPart-MonitorChartPart-1bd243d6-36d8-4329-8ed0-02aa14c24788",
                "StartboardPart-MonitorChartPart-1bd243d6-36d8-4329-8ed0-02aa14c24a01"
              ]
            }
          }
        }
      }
    }
  }