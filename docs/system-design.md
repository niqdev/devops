# System Design

## Resources

* [Designing Data-Intensive Applications](https://amzn.to/2lKJMvU) (2017) by Martin Kleppmann (Book)
* [Domain-Driven Design: Tackling Complexity in the Heart of Software](https://amzn.to/2VTvGYS) (2003) by Eric Evans (Book)
* [Functional and Reactive Domain Modeling](https://www.manning.com/books/functional-and-reactive-domain-modeling) (2016) by Debasish Ghosh (Book)
* [Versioning in an Event Sourced System](https://leanpub.com/esversioning/read) (Book)
* [Exploring CQRS and Event Sourcing](https://docs.microsoft.com/en-us/previous-versions/msp-n-p/jj554200(v%3dpandp.10)) (Book)
* [CQRS](https://www.martinfowler.com/bliki/CQRS.html) by Martin Fowler
* [Clarified CQRS](http://udidahan.com/2009/12/09/clarified-cqrs)
* [1 Year of Event Sourcing and CQRS](https://hackernoon.com/1-year-of-event-sourcing-and-cqrs-fb9033ccd1c6)
* [Eventually Consistent - Revisited](https://www.allthingsdistributed.com/2008/12/eventually_consistent.html)
* [On Designing and Deploying Internet-Scale Services](https://www.usenix.org/legacy/events/lisa07/tech/full_papers/hamilton/hamilton_html)
* [There is No Now](https://queue.acm.org/detail.cfm?id=2745385)
* [Online Event Processing](https://queue.acm.org/detail.cfm?id=3321612)
* [The world beyond batch: Streaming 101](https://www.oreilly.com/ideas/the-world-beyond-batch-streaming-101)
* [Jepsen](https://aphyr.com/tags/Jepsen) (Blog)
* [The Paper Trail](https://www.the-paper-trail.org) (Blog)

**CAP Theorem**

* [Brewer's CAP Theorem](http://www.julianbrowne.com/article/brewers-cap-theorem)
* [CAP Twelve Years Later: How the "Rules" Have Changed](https://www.infoq.com/articles/cap-twelve-years-later-how-the-rules-have-changed)
* [Please stop calling databases CP or AP](https://martin.kleppmann.com/2015/05/11/please-stop-calling-databases-cp-or-ap.html)
* [The CAP FAQ](https://www.the-paper-trail.org/page/cap-faq)

**Papers**

* [The Google File System](https://static.googleusercontent.com/media/research.google.com/en//archive/gfs-sosp2003.pdf)
* [MapReduce: Simplified Data Processing on Large Clusters](https://static.googleusercontent.com/media/research.google.com/en//archive/mapreduce-osdi04.pdf)
* [Raft: In Search of an Understandable Consensus Algorithm](https://raft.github.io/raft.pdf)
* [Paxos Made Simple](https://www.microsoft.com/en-us/research/uploads/prod/2016/12/paxos-simple-Copy.pdf)
* [Zab: A simple totally ordered broadcast protocol](http://diyhpl.us/~bryan/papers2/distributed/distributed-systems/zab.totally-ordered-broadcast-protocol.2008.pdf)
* [The Chubby lock service for loosely-coupled distributed systems](https://static.googleusercontent.com/media/research.google.com/en//archive/chubby-osdi06.pdf)
* [Spanner: Google's Globally-Distributed Database](https://static.googleusercontent.com/media/research.google.com/en//archive/spanner-osdi2012.pdf)
* [Dynamo: Amazon’s Highly Available Key-value Store](https://s3.amazonaws.com/AllThingsDistributed/sosp/amazon-dynamo-sosp2007.pdf)
* [HyperLogLog in Practice](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/40671.pdf)
* [Dapper, a Large-Scale Distributed Systems Tracing Infrastructure](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/36356.pdf)
* [Large-scale cluster management at Google with Borg](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/43438.pdf)
* [Linearizability: A Correctness Condition for Concurrent Objects](https://cs.brown.edu/~mph/HerlihyW90/p463-herlihy.pdf)
* [Harvest, Yield, and Scalable Tolerant Systems](https://s3.amazonaws.com/systemsandpapers/papers/FOX_Brewer_99-Harvest_Yield_and_Scalable_Tolerant_Systems.pdf)
* [Life beyond Distributed Transactions](http://www-db.cs.wisc.edu/cidr/cidr2007/papers/cidr07p15.pdf)
* [The ϕ Accrual Failure Detector](https://web.archive.org/web/20170517022242/http://fubica.lsd.ufcg.edu.br/hp/cursos/cfsc/papers/hayashibara04theaccrual.pdf)
* [Conflict-free Replicated Data Types](https://hal.inria.fr/inria-00609399v1/document)
* [FLP - Impossibility of Distributed Consensus with One Faulty Process](http://macs.citadel.edu/rudolphg/csci604/ImpossibilityofConsensus.pdf)
* [SEDA: An Architecture for Well-Conditioned, Scalable Internet Services](http://nms.lcs.mit.edu/~kandula/projects/killbots/killbots_files/seda-sosp01.pdf)
* [Pregel: A System for Large-Scale Graph Processing](https://kowshik.github.io/JPregel/pregel_paper.pdf)
* [Hashed and Hierarchical Timing Wheels](http://www.cs.columbia.edu/~nahum/w6998/papers/sosp87-timing-wheels.pdf)
* [Merkle Hash Tree based Techniques for Data Integrity of Outsourced Data](http://ceur-ws.org/Vol-1366/paper13.pdf)
* [What Every Programmer Should Know About Memory](https://www.akkadia.org/drepper/cpumemory.pdf)
* [Fallacies of Distributed Computing Explained](http://www.rgoarchitects.com/Files/fallacies.pdf)

## Notes

* [*Domain-driven design (DDD)*](http://dddcommunity.org/learning-ddd/what_is_ddd) is an approach to developing software for complex needs by deeply connecting the implementation to an evolving model of the core business concepts. Domain-driven design is not a technology or a methodology. DDD provides a structure of practices and terminology for making design decisions that focus and accelerate software projects dealing with complicated domains. Its premise is:
    * Place the project's primary focus on the core domain and domain logic
    * Base complex designs on a model
    * Initiate a creative collaboration between technical and domain experts to iteratively cut ever closer to the conceptual heart of the problem

* Any domain model of nontrivial complexity is a collection of smaller models, each with its own data and domain vocabulary. In the world of *domain-driven design*, the term **bounded context** denotes one such smaller model within the whole. So the complete domain model is really a collection of bounded contexts

* Types of domain elements
    * An **entity** it's uniquely identifiable, has an identity and might change attributes in the course of its entire life-time within the system - an entity has an identity that can't change
    * A **value object** it's uniquely identifiable, is immutable and you can't change the contents without changing the object itself, after you create it - a value object has a value that can't change
    * In a **service**, multiple domain entities interact according to specific business rules and deliver a specific functionality in the system

* Lifecycle of a domain object
    * **Creation**: how the object is created within the system
    * **Participation in behaviors**: how the object is represented in memory when it interacts within the system
    * **Persistence**: how the object is maintained in the persistent form

* Patterns
    * The **factory** lets you create different types of objects using the same API
        * It keeps all creational code in one place
        * It abstracts the process of creation of an entity from the caller
    * An **aggregate** can consist of one or more entities, value objects and other primitive attributes. Besides ensuring the consistency of business rules, an aggregate within a bounded context is also often looked at as a *transaction boundary* in the model. *Aggregates are created by factories and represent the underlying entities in memory during the active phase of the objects' lifecycle*
    * A **repository** gives the interface for parking an aggregate in a persistent form so that can be fetched back to an in-memory entity representation when needed. The persistent model of the aggregate may be entirely different from the in-memory aggregate representation and is mostly driven by the underlying storage data model

* *The three types of elements participate in domain interactions and their lifecycles are controlled by the three patterns*. This interaction needs to reflect the underlying business semantics and must contain **vocabulary** from the problem domain modelled. Vocabulary it means the names of participating objects and the behaviors that are executed as part of the use cases. Having a consistent **ubiquitous language** has a lot to do with designing proper APIs of a model, which is known as *domain-specific language (DSL)*

* *Latency* is defined as the time period that elapses between a request and a response. If is possible to bind the latency to an acceptable limit to users, you achieve *responsiveness*. And being responsive is the primary criterion of a model being *reactive*

* Characteristics of a reactive model
    * Responsive to user interaction
    * Resilient i.e. responsive to failures
    * Elastic i.e. responsive to varying load
    * Message-driven i.e. to stay responsive and elastic, systems must be loosely coupled and minimize blocking by using asynchronous message passing

* *Design for failure*. This is a core concept when developing large services that are comprised of many cooperating components. Those components will fail and they will fail frequently

* One of the ways to make a system elastic is by reducing the coupling between the components of the model. Reactive models encourage loosely connected architectures that use asynchronous message boundaries as the means of nonblocking communications and components that interact using immutable messages without any sharing of mutable state to promote transparency of location, concurrency models and other paradigms which are cornerstone of functional programming

* An event is a form of notification. *Domain events* are based on the action that they perform within the domain model and are immutable. Such domain models are called *self-tracing* models, because domain event logs make our models traceable at any point in time
    * *Uniquely identifiable as a type* - for each event, you have a type in your model
    * *Self-contained as a behavior* — Every domain event contains all information relevant to the change that just occurred in the system
    * *Observable by consumers* - Events are meant to be consumed for further action by downstream components of your model
    * *Time relevant* — A monotonicity of time is built into the stream of events

commands vs eventds
---

TODO acronyms

* OLEP online event processing
* OLTP online transaction processing
* OLAP online analytical processing
* DDD
* CQRS
* Event Source
* Eventual Consistency
* CRDT
* CAP theorem
* two-phase commit
* circuit breaker pattern
* SAGA
* SLA service-level agreement
* ACID
* ACID 2.0
    * **Associative** grouping doesn't matter `a+(b+c)=(a+b)+c`
    * **Commutative** order doesn't matter `a+b=b+a`
    * **Idempotent** duplication doesn't matter `a+a=a`
