Message-ID: <6CDD95AD0FF2D311BC6A009027DC6B990530EDD8@MAIL1>
From: James Lay <jlay@ameriben.com>
Subject: RE: [Bridge] recent 2.6 kernels hang on bridge shutdown - solved
Date: Sat, 5 Feb 2005 07:20:49 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Folks,

For what it's worth I used to have the hang at shutdown with brnf and kernel
2.4.26.  An fsck on the boot drive fixed it (telling me it had nothing to do
with whatever kernel I was running)...have you tried that?

James

-----Original Message-----
From: Santiago Garcia Mantinan [mailto:bridge@manty.net]
Sent: Saturday, February 05, 2005 5:51 AM
To: Mirko Parthey
Cc: bridge@lists.osdl.org; Stephen Hemminger
Subject: Re: [Bridge] recent 2.6 kernels hang on bridge shutdown -
solved


Hi!

> > Are you running IPV6? if so it is most likely related to IPV6.
> Yes, indeed.
> Since I currently don't need IPv6, I disabled it - problem solved.

This is not related to IPv6 at all, several people have reported it to me
and don't run IPv6 or have support for it in their kernels.

However, it is not easy to reproduce this problem, it happens to me only on
one of my machines, and only sometimes, and it doesn't happen on any of my
other bridges, I've been trying to get the steps to reproduce it but I'm not
able :-(

Mirko, if you can do more tests, maybe you find that your machine it still
suffers from this.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
