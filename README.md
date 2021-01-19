# Nebula
Native edge based unbiased leverage algorithm.

Centralized cloud infrastructures have become the popular platforms for data-intensive computing today. However, they suffer from inefficient data mobility due to the centralization of cloud resources, and hence, 
are highly unsuited for geo-distributed data-intensive applications where the data may be spread at multiple geographical locations. In this paper, we present Nebula: a dispersed edge cloud infrastructure that explores the use of voluntary
resources for both computation and data storage. We describe the lightweight Nebula architecture that enables distributed data-intensive computing through a number of optimization techniques including location-aware data and
computation placement, replication, and recovery. We evaluate Nebula performance on an emulated volunteer platform that spans over 50 PlanetLab nodes distributed across Europe, and show how a common data-intensive
computing framework, MapReduce, can be easily deployed and run on Nebula. We show Nebula MapReduce is robust to a wide array of failures and substantially outperforms other wide-area versions based on emulated existing
systems.

Requirements:
Python 2.7
flask
wamp

There is a prision management website that is hosted inside this system.
