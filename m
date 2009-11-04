Date: Wed, 4 Nov 2009 16:58:49 -0500 (EST)
From: Jon Lewis <jlewis@lewis.org>
In-Reply-To: <4AF1F6AE.9050506@pandora.be>
Message-ID: <Pine.LNX.4.61.0911041654570.22812@soloth.lewis.org>
References: <Pine.LNX.4.61.0911040949290.22812@soloth.lewis.org>
	<4AF1F6AE.9050506@pandora.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Bridge] ebtables counters bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>
Cc: Bridge@lists.linux-foundation.org

Cool.  I was going to check out a copy from cvs, but the instructions at
http://ebtables.sourceforge.net/downloads/cvs.html
seem to be out of date, and anonymous access to 
cvs.sourceforge.net:/cvsroot/ebtables is denied.

$ cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/ebtables login
Logging in to :pserver:anonymous@cvs.sourceforge.net:2401/cvsroot/ebtables
CVS password:
cvs [login aborted]: connect to [cvs.sourceforge.net]:2401 failed: 
Connection refused


On Wed, 4 Nov 2009, Bart De Schuymer wrote:

> Hi Jon,
>
> Thanks for the report. I've fixed the bug in cvs. A new release will follow 
> later.
>
> cheers,
> Bart
>
> Jon Lewis schreef:
>> I posted this yesterday to the netfilter list, but I'm not sure that was 
>> the right list for this issue.  I seem to have [re]discovered a bug very 
>> similar to if not the same as
>> http://osdir.com/ml/linux.network.bridge.ebtables.devel/2003-06/msg00002.html
>> 
>> According to the mailing list archive, that bug was fixed in 2003...but 
>> either it wasn't, or it's been reintroduced.
>> 
>> I'm using ebtables-v2.0.9-1.tar.gz with CentOS 5.3
>> 2.6.18-164.el5xen #1 SMP Thu Sep 3 04:03:03 EDT 2009 x86_64 x86_64 x86_64 
>> GNU/Linux
>> 
>> Using ebtables, I've setup a number of user-defined chains.  In the INPUT 
>> and FORWARD chains, I have rules to jump to these user-defined chains.
>> 
>> I've noticed that any change (adding or deleting a rule) to any chain (at 
>> least the INPUT, FORWARD, or any other user-defined one) causes the 
>> counters for the last user-defined chain to be reset to 0's.  Creating a 
>> new user-defined chain does not seem to affect counters.  Deleting that new 
>> user-defined chain does reset the counters in the last remaining 
>> user-defined chain.
>> 
>> I just verified the same behavior on a RHEL 5.4 system running
>> 2.6.18-164.2.1.el5 #1 SMP Mon Sep 21 04:37:42 EDT 2009 x86_64 x86_64 x86_64 
>> GNU/Linux
>> with
>> 
>> Name        : ebtables                     Relocations: (not relocatable)
>> Version     : 2.0.8.2                           Vendor: Dag Apt Repository, 
>> http://dag.wieers.com/apt/
>> Release     : 1.el5.rf                      Build Date: Fri 14 Mar 2008 
>> 12:17:48 AM EDT
>> Install Date: Sat 31 Oct 2009 03:09:00 PM EDT      Build Host: 
>> lisse.leuven.wieers.com
>> Group       : System Environment/Base       Source RPM: 
>> ebtables-2.0.8.2-1.el5.rf.src.rpm
>> Size        : 558998                           License: GPL
>> Signature   : DSA/SHA1, Sat 15 Mar 2008 12:52:06 AM EDT, Key ID 
>> a20e52146b8d79e6
>> Packager    : Dag Wieers <dag@wieers.com>
>> URL         : http://ebtables.sourceforge.net/
>> 
>> Code from the patch/fix posted
>> http://osdir.com/ml/linux.network.bridge.ebtables.devel/2003-06/msg00004.html
>> 
>> does not appear to be in the current (2.0.9) ebtables.
>> 
>> ----------------------------------------------------------------------
>>   Jon Lewis                   |  I route
>>   Senior Network Engineer     |  therefore you are
>>   Atlantic Net                |
>> _________ http://www.lewis.org/~jlewis/pgp for PGP public key_________
>> _______________________________________________
>> Bridge mailing list
>> Bridge@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/bridge
>> 
>> 
>> 
>
>
> -- 
> Bart De Schuymer
> www.artinalgorithms.be
>

----------------------------------------------------------------------
  Jon Lewis                   |  I route
  Senior Network Engineer     |  therefore you are
  Atlantic Net                |
_________ http://www.lewis.org/~jlewis/pgp for PGP public key_________
