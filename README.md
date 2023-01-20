# RKE2 on AWS
RKE2 is a k8s distribution intended for government entity use. 

## Description
This repository is a guide to setting up RKE2 on AWS. RKE2 is flexible for deployment method and can be tailored to best suit you and your needs. This repository is a stepping stone to introduce your own workflow to meet your needs.

## Purpose
This is inteded to demonstrate deploying RKE2 in a highly available, resilient, scalable, and simple method on AWS. This is repo is for learning purposes and to best fit a solution in future applications. 

## Overview
This repo will provision the following:
* Nodepools: Self-bootstrapping and auto-joining groups of EC2 instances
* AWS NLB: Control plane static address

This leverages RKE2 to provide simple, sshless(Rancher tutorial requires ssh) bootstrapping process for node pools. Both the servers and agents w/in the cluster are one or more Auto Scaling Groups (ASG) w/ minimal userdata required for creating or joining an RKE2 cluster.

On ASG boot, every node will:
1. Install RKE2
2. Fetch RKE2 cluster token from a secure secret store
3. Initialize or join an RKE2 cluster

## Maintainer
* @fostemi
