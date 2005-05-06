Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bridge] How to keep bridge up after reboot
Date: Fri, 6 May 2005 15:28:04 -0400
Message-ID: <EDF30175FE4D804B83444FB153172A5054974C@louexch.KiZAN.net>
From: "Jeff Gercken" <JeffG@kizan.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Scott Ellerbrock <sellerbrock@saferent.com>
Cc: bridge@lists.osdl.org

Sorry, I shouldn't try to answer questions w/o my first cup of coffee.

On SUSE most ppl seem to create a script in /etc/init.d/ then put a
symlink pointing to it in the runlevel rc you're using.  A quick who -r
should tell you which runlevel you use (typ runlevel 5)

So in /etc/init.d/ create a file called bridge
	#!/bin/sh
	brctrl addbr bla...
	brctrl addif bla...
	whatever else...

make it executable:
	chmod 700 /etc/init.d/bridge

put a symlink in /etc/init.d/rc5.d:
	ln -s /etc/init.d/rc5.d/S99bridge /etc/init.d/bridge 

That should be it.  Check the YaST runlevel editor to be sure.

-----Original Message-----
From: bridge-bounces@lists.osdl.org
[mailto:bridge-bounces@lists.osdl.org] On Behalf Of Stephen Hemminger
Sent: Friday, May 06, 2005 3:00 PM
To: Scott Ellerbrock
Cc: bridge@lists.osdl.org
Subject: Re: [Bridge] How to keep bridge up after reboot

On Thu, 5 May 2005 16:06:59 -0600 
Scott Ellerbrock <sellerbrock@saferent.com> wrote:

> I am sorry for the newbie question. I am working with SUSE 9.2 and I
have
> followed the instructions at
> http://tldp.org/HOWTO/Ethernet-Bridge-netfilter-HOWTO-4.html
> 
> I have gotten my bridge to work flawlessly, but I can't figure out how
to
> get the bridge to come up after a reboot. 
> 
> Any help or pointers to docs that will get me going in the right
direction
> would be greatly appreciated.
> 
> Scott
>  
It is really depends on the distribution, some of the firewall's etc
have
gui's and startup scripts to handle.  You might look in the SUSE doc's.

