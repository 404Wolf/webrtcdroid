#import "@preview/glossarium:0.5.9": make-glossary, register-glossary, print-glossary, gls, glspl
#show: make-glossary

#let entry-list = (
  (
    key: "kuleuven",
    short: "KU Leuven",
    long: "Katholieke Universiteit Leuven",
    description: "A university in Belgium.",
  ),
)
#register-glossary(entry-list)

#align(center + horizon)[
 #v(-10em)

  #text(size: 24pt, weight: "bold")[
    Software Requirements Specification for _WebRTCDroid_
  ]

  #v(1em)

  #text(size: 14pt)[
    Prepared by Wolf Mermelstein and Alesandro Mason
  ]

  #v(1em)

  #text(size: 16pt, weight: "semibold")[
    Case Western Reserve University
  ]

  #v(1em)

  #text(size: 14pt)[
    September 14, 2025
  ]
]

#pagebreak()

#outline(depth:3)

#pagebreak()

= Introduction

== Purpose // alesandro

// Describe the purpose of this SRS and its intended audience.

This SRS lays out the scope of our WebRTC android-in-the-browser project, its
features, and the general architecture. The intended audience is both developers
looking to contribute, and potential API consumers of the project.

== Document Conventions // wolf

// Describe any standards or typographical conventions that were followed when
// writing this SRS, such as fonts or highlighting that have special
// significance. For example, state whether priorities for higher-level
// requirements are assumed to be inherited by detailed requirements, or whether
// every requirement statement is to have its own priority.

== Intended Audience and Reading Suggestions // wolf

// Describe the different types of reader that the document is intended for,
// such as developers, project managers, marketing staff, users, testers, and
// documentation writers. Describe what the rest of this SRS contains and how it
// is organized. Suggest a sequence for reading the document, beginning with the
// overview sections and proceeding through the sections that are most pertinent
// to each reader type.

== Project Scope // alesandro

// Provide a short description of the software being specified and its purpose,
// including relevant benefits, objectives, and goals. Relate the software to
// corporate goals or business strategies. If a separate vision and scope
// document is available, refer to it rather than duplicating its contents here.
// An SRS that specifies the next release of an evolving product should contain
// its own scope statement as a subset of the long-term strategic product
// vision.

== References // wolf

// List any other documents or Web addresses to which this SRS refers. These may
// include user interface style guides, contracts, standards, system
// requirements specifications, use case documents, or a vision and scope
// document. Provide enough information so that the reader could access a copy
// of each reference, including title, author, version number, date, and source
// or location.

= Overall Description

== Product Perspective // wolf

// Describe the context and origin of the product being specified in this SRS.
// For example, state whether this product is a follow-on member of a product
// family, a replacement for certain existing systems, or a new, self-contained
// product. If the SRS defines a component of a larger system, relate the
// requirements of the larger system to the functionality of this software and
// identify interfaces between the two. A simple diagram that shows the major
// components of the overall system, subsystem interconnections, and external
// interfaces can be helpful.

== Product Features // alesandro

// Summarize the major features the product contains or the significant
// functions that it performs or lets the user perform. Details will be provided
// in Section 3, so only a high level summary is needed here. Organize the
// functions to make them understandable to any reader of the SRS. A picture of
// the major groups of related requirements and how they relate, such as a top
// level data flow diagram or a class diagram, is often effective.

== User Classes and Characteristics // alesandro

// Identify the various user classes that you anticipate will use this product.
// User classes may be differentiated based on frequency of use, subset of
// product functions used, technical expertise, security or privilege levels,
// educational level, or experience. Describe the pertinent characteristics of
// each user class. Certain requirements may pertain only to certain user
// classes. Distinguish the favored user classes from those who are less
// important to satisfy.

== Operating Environment // wolf

// Describe the environment in which the software will operate, including the hardware platform,
// operating system and versions, and any other software components or applications with which it
// must peacefully coexist.

== Design and Implementation Constraints // wolf

// Describe any items or issues that will limit the options available to the developers. These might
// include: corporate or regulatory policies; hardware limitations (timing requirements, memory
// requirements); interfaces to other applications; specific technologies, tools, and databases to be
// used; parallel operations; language requirements; communications protocols; security
// considerations; design conventions or programming standards (for example, if the customer's
// organization will be responsible for maintaining the delivered software).

== User Documentation // wolf

// List the user documentation components (such as user manuals, on-line help, and tutorials) that
// will be delivered along with the software. Identify any known user documentation delivery formats
// or standards.

== Assumptions and Dependencies // wolf

// List any assumed factors (as opposed to known facts) that could affect the requirements stated in
// the SRS. These could include third-party or commercial components that you plan to use, issues
// around the development or operating environment, or constraints. The project could be affected if
// these assumptions are incorrect, are not shared, or change. Also identify any dependencies the
// project has on external factors, such as software components that you intend to reuse from
// another project, unless they are already documented elsewhere (for example, in the vision and
// scope document or the project plan).

= System Features // alessandro

// This template illustrates organizing the functional requirements for the product by system
// features, the major services provided by the product. You may prefer to organize this section by
// use case, mode of operation, user class, object class, functional hierarchy, or combinations of
// these, whatever makes the most logical sense for your product.
//
// - Getting a screen and audio streamed to a react component in a web browser.
// - Creating a programmatic way to "spin up" an emulator with an HTTP API.
// - Making a front end web appication to use that endpoint and show your running device.
// - Allow having multiple emulators that are running at the same time.
// - Sandboxing a android phone in a docker container *with a mounted SD card*.
// - Supporting controlling the device from the browser over a WebRTC data stream.
// - "Multiplayer" (many people viewing the same device with a share link).
// - "Multiplayer" and allowing many people to **control** the same device.
// - Deploying to edge containers like fly.io OR building a multitenent system on a bare metal instance.

== REST API to manage android instances

// State the feature name in just a few words.

=== Description and Priority

// Provide a short description of the feature and indicate whether it is of High, Medium, or
// Low priority. You could also include specific priority component ratings, such as
// benefit, penalty, cost, and risk (each rated on a relative scale from a low of 1 to a
// high of 9).

=== Stimulus/Response Sequences

// List the sequences of user actions and system responses that stimulate the behavior
// defined for this feature. These will correspond to the dialog elements associated with
// use cases.

=== Functional Requirements

// Itemize the detailed functional requirements associated with this feature. These are the
// software capabilities that must be present in order for the user to carry out the
// services provided by the feature, or to execute the use case. Include how the product
// should respond to anticipated error conditions or invalid inputs. Requirements should
// be concise, complete, unambiguous, verifiable, and necessary. Use "TBD" as a
// placeholder to indicate when necessary information is not yet available.

// Each requirement should be uniquely identified with a sequence number or a meaningful
// tag of some kind.

// REQ-1:
// REQ-2:

== Live video, audio, and interaaction streaming

// Additional system features follow the same structure as System Feature 1

== Web App to interface with the device manager

// Additional system features follow the same structure as System Feature 1

= External Interface Requirements

== Software Interfaces // wolf

_Shims_:  For the shim that runs inside the containers alongside android emulators, we will be
Go has a reference implementation of the WebRTC protocol, called [pion](https://github.com/pion/webrtc), which we will use

// Describe the connections between this product and other specific software components (name
// and version), including databases, operating systems, tools, libraries, and integrated commercial
// components. Identify the data items or messages coming into the system and going out and
// describe the purpose of each. Describe the services needed and the nature of communications.
// Refer to documents that describe detailed application programming interface protocols. Identify
// data that will be shared across software components. If the data sharing mechanism must be
// implemented in a specific way (for example, use of a global data area in a multitasking operating
// system), specify this as an implementation constraint.

= Other Nonfunctional Requirements // alessandro

== Performance Requirements // alessandro

// If there are performance requirements for the product under various circumstances, state them
// here and explain their rationale, to help the developers understand the intent and make suitable
// design choices. Specify the timing relationships for real time systems. Make such requirements as
// specific as possible. You may need to state performance requirements for individual functional
// requirements or features.

== Safety Requirements // alessandro

// Specify those requirements that are concerned with possible loss, damage, or harm that could
// result from the use of the product. Define any safeguards or actions that must be taken, as well as
// actions that must be prevented. Refer to any external policies or regulations that state safety
// issues that affect the product's design or use. Define any safety certifications that must be
// satisfied.

== Security Requirements // alessandro

// Specify any requirements regarding security or privacy issues surrounding use of the product or
// protection of the data used or created by the product. Define any user identity authentication
// requirements. Refer to any external policies or regulations containing security issues that affect
// the product. Define any security or privacy certifications that must be satisfied.

== Software Quality Attributes // alessandro

// Specify any additional quality characteristics for the product that will be important to either the
// customers or the developers. Some to consider are: adaptability, availability, correctness, flexibility,
// interoperability, maintainability, portability, reliability, reusability, robustness, testability, and
// usability. Write these to be specific, quantitative, and verifiable when possible. At the least, clarify
// the relative preferences for various attributes, such as ease of use over ease of learning.

= Other Requirements

// Define any other requirements not covered elsewhere in the SRS. This might include database
// requirements, internationalization requirements, legal requirements, reuse objectives for the
// project, and so on. Add any new sections that are pertinent to the project.

= Appendix A: Glossary

// Define all the terms necessary to properly interpret the SRS, including acronyms and
// abbreviations. You may wish to build a separate glossary that spans multiple projects or the entire
// organization, and just include terms specific to a single project in each SRS.

#print-glossary(
  entry-list,
  show-all: true
)

= Appendix B: Analysis Models // alessandro

// Optionally, include any pertinent analysis models, such as data flow diagrams, class diagrams,
// state-transition diagrams, or entity-relationship diagrams.

= Appendix C: Issues List // wolf

// This is a dynamic list of the open requirements issues that remain to be resolved, including
// TBDs, pending decisions, information that is needed, conflicts awaiting resolution, and the like.
