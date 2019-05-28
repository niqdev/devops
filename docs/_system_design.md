* [Clarified CQRS](http://udidahan.com/2009/12/09/clarified-cqrs)
* [DDD Community](http://dddcommunity.org)

* *Domain-driven design (DDD)* is an approach to developing software for complex needs by deeply connecting the implementation to an evolving model of the core business concepts. Domain-driven design is not a technology or a methodology. DDD provides a structure of practices and terminology for making design decisions that focus and accelerate software projects dealing with complicated domains. Its premise is:
    * Place the project's primary focus on the core domain and domain logic
    * Base complex designs on a model
    * Initiate a creative collaboration between technical and domain experts to iteratively cut ever closer to the conceptual heart of the problem
* Any domain model of nontrivial complexity is a collection of smaller models, each with its own data and domain vocabulary
In the world of *domain-driven design*, the term **bounded context** denotes one such smaller model within the whole. So the complete domain model is really a collection of bounded contexts
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
