Message-ID: <445D37D9.4040401@osdl.org>
Date: Sat, 06 May 2006 16:57:13 -0700
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Subject: Re: [Bridge] Google SoC proposal
References: <20060506175414.GB11857@hell.org.pl>
In-Reply-To: <20060506175414.GB11857@hell.org.pl>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: =?UTF-8?B?VGFkZXVzeiBBbmRyemVqIEthZMWCdWJvd3NraQ==?= <yess@hell.org.pl>
Cc: bridge@lists.osdl.org

Tadeusz Andrzej Kadłubowski wrote:
> Hello,
>
> I am a student considering participating in Google Summer of Code program.
>
> I came across Stephen Hemminger's idea of implementing a RSTP posted on
> http://developer.osdl.org/dev/soc/ and found it interesting.
>
> In attachment there's my proposal, which I just submitted to google.
>
> Please share your comments.
>
>   
> ------------------------------------------------------------------------
>
> 			Linux RSTP implementation
> 			 Google SoC Application
>
> Name:	Tadeusz Andrzej Kadłubowski
> Email:  yess @ hell org pl
> IRC:	yess @ freenode
>
> The aim of this project is to create a Linux Rapid Spanning Tree
> Protocol implementation as proposed by Mr Stephen Hemminger on
> http://developer.osdl.org/dev/soc/
>
> The system will be written in C and work as a daemon. It will be
> configurable with a command line tool similar to brctl (probably a
> modified brctl).
>
> The tests will be a set of scripts - most likely perl or python unit
> testing library will be used.
>
> SCHEDULE OUTLINE
> ================
>
> The project will take 13 weeks. We can assume 40 hours in a working
> week.  My current duties occupy 2 days a week.
>
> May:
> 	Reading and learning (IEEE standard, linux/net/core/,
> 	linux/net/bridge/, brctl sources, maybe documentation from UNH
> 	mentioned on http://developer.osdl.org/dev/soc/)
> June:
> 	Messages from and to the kernel via rtnetlink interface
> 	Sending, receiving and parsing of BDPU messages
> 	Graph theory logic
> 	Exam in numerical mathematics will occupy my attention for 
> 	about a week. :|
> July:
> 	State machine logic
> 	Timers
> 	User interface
> 	Framework for unit testing
> 	Numerous test units
> August:
> 	Building scripts, packaging and release (if standalone)
> 	More documentation
> 	More testing
> 	
> DELIVERABLES
> ============
>
> * Linux RSTP daemon
> * Command line tool to operate it
> * Kernel bridge module patch in order to notify the userland (as
>   needed)
> * Set of test units
> * Documentation (both for end-user and concerning inner structure)
>
> MY USEFUL SKILLS
> ==============
>
> * 6 years of C experience on Linux (with tools such as gdb, strace, vallgrind
>   etc.)
> * General idea of ,,Unix way of doing things'' and devotion for simplicity.
> * Excellent understanding of graph theory, finite state automata and other
>   necessary theoretical concepts.
> * Some experience with low-level things (I took a small part in developing
>   acpi4asus Linux driver having its main developer as a roommate)
> * Enthusiasm for scripting languages (mostly python, bash and perl)
>
> BIO + MOTIVATION
> ================
>
> I'm a third year student at a CS faculty of the University of Gdańsk, Poland.
> Having completed most of my courses on straight A's I feel perfectly capable
> of completing this project.
>
> I've been using Linux since '99. One of my computers operated as a STP-enabled
> bridge in my high school network - that's where I learned basic networking
> concepts. In those times I also learned C, which now I am perfectly familiar
> with.
>
> Recently I've completed third semester of Cisco CCNA course. This course gave
> me insight into the world of embedded networking equipment and taught me a lot
> about numerous aspects of networks. On the other hand their proprietary attitude
> seemed odd and cumbersome to me. I started to see a great potential for
> Linux-based networking equipment.
>
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
>   
Pleas submit all SoC requests through the Google process. You need to 
register on
http://code.google.com/soc/student_step1.html

Then it has a form to submit with your proposal.

Thanks.
