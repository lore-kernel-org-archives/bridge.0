Return-Path: <vitas@nppfactor.kiev.ua>
From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Tue, 8 Nov 2011 12:32:01 +0200
References: <4EB8F874.8090408@cipi.unige.it>
In-Reply-To: <4EB8F874.8090408@cipi.unige.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201111081232.01748.vitas@nppfactor.kiev.ua>
Subject: Re: [Bridge] RSTP implementation status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Tuesday 08 November 2011 11:37:56 Martino Fornasa wrote:
> Hi all.
> I'm interested in RSTP implementation (and maybe in contributing to it).
>
> I read this
> [http://lkml.indiana.edu/hypermail/linux/net/0807.1/0011.html] message,
> and I had a look on the ongoing RSTP project hosted at
> [https://github.com/shemminger/RSTP]. Is this project still running?
>
> I noticed that such a ongoing project is based on rstplib
> [http://rstplib.sourceforge.net/]. By taking a brief look at the code,
> it seems to me that such a code is based on the obsolete 802.1w
> specification, while the newest specification for RSTP is contained in
> 802.1D-2004; and such a specification (beside incorporating
> compatibility with STP) is radically different from 802.1w (e.g.,
> different set of states on state machines...), and it is not easy to
> understand the amount of interoperability between the two.
>

Hello, Martino!
Not really an expert in 802.1w flavor of RSTP, so can't really say if there 
are any differences in behavior of 802.1w- and 802.1D- compatible  
implementations. Just want to point at two alternative projects based on more 
recent standards:

1)
There is 802.1D-compatible RSTP implementation by Aji Srinivas which he 
announced on this list:
http://lists.linux-foundation.org/pipermail/bridge/2009-February/006178.html

I have adopted it in my projects and even have found and patched some bugs. As 
for me it passes some smoke tests but I never let it in production, because 
of the lack of more serious testing.

2)
Also I started open-source MSTP (802.1Q-2005) project,  you can find it here:
http://sourceforge.net/p/mstpd/wiki/Home/

It is based on the more recent standard and can be restricted (if you need) to 
the rstp-only operation by setting "setforcevers" parameter to "rstp".

Again, it passes some smoke tests and behaves reasonably but it lacks serious 
testing.
 
> I think that a serious issue in implementing network bridging/routing
> protocols is to proper validate and testing it. For example, I know that
> there are companies that offer commercial validation system for network
> protocol. As some RSTP implementations as been put in the past in the
> kernel, and STP is already in it, are such implementations have been
> tested and validated? How?
>

Indeed, this is the biggest problem. There are tests which are considered as 
industry standards: UNH IOL tests. For example, MSTP tests:
http://www.iol.unh.edu/services/testing/bfc/testsuites/#Multiple_Spanning_Tree_(MSTP)_Operations_Test_Suite
and
http://www.iol.unh.edu/services/testing/bfc/testsuites/#Multiple_Spanning_Tree_Protocol_(MSTP)_Multi-System_Interoperability_Test_Suite

But these tests use special Ethernet frames, and the content of those test 
frames isn't available freely. Personally I can not figure how to get those 
frames (suspect, it is simply impossible for the small enterprise, as mine 
is).
That is where the show stops for me. I have code and it needs testing, and... 

-- 
Vitalii Demianets
