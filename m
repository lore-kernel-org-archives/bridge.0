Date: Fri, 27 Apr 2007 20:38:06 +1000
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Message-ID: <H00000690017d371.1177670277.mail.pacificwireless.net.au@MHS>
In-Reply-To: <H00000690017cf61.1177649582.mail.pacificwireless.net.au@MHS>
Subject: RE: [Bridge] PVST
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>, shemminger <shemminger@linux-foundation.org>
Cc: bridge <bridge@lists.linux-foundation.org>

>(I'm particularly referring to a 6.2.19-ish kernel, before the patches of the last few days) 

Err, perhaps I actually mean 2.6.19-ish....

-----Original Message-----
From: Leigh Sharpe 
Sent: Friday, 27 April 2007 2:53 PM
To: shemminger
Cc: bridge
Subject: RE: [Bridge] PVST


So, if I put a linux bridge in a network which has PVST packets flying around, will it pass them, or silently drop them?
Should I have STP disabled on my linux box?
(I'm particularly referring to a 6.2.19-ish kernel, before the patches of the last few days) 


Regards,
             Leigh
 
Leigh Sharpe
Network Systems Engineer
Pacific Wireless
Ph +61 3 9584 8966
Mob 0408 009 502
Helpdesk 1300 300 616
email lsharpe@pacificwireless.com.au
web www.pacificwireless.com.au

-----Original Message-----
From: shemminger@linux-foundation.org [mailto:shemminger@linux-foundation.org] 
Sent: Friday, April 27, 2007 2:07 PM
To: Leigh Sharpe
Cc: bridge
Subject: Re: [Bridge] PVST

On Fri, 27 Apr 2007 10:47:42 +1000
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

> Hi All, 
> Does the current bridging code handle PVST properly, or just ordinary
> STP?

Ordinary, STP.  The 2.6.22 kernel will have all the bits to run STP in
user mode, and there is a version of RSTP in userspace see:
	git://git.kernel.org/pub/scm/linux/kernel/shemminger/git/rstp.git

The RSTP code uses the rstplib and it knows about VLAN's, but the hooks
aren't there yet. Eventually, full MSTP 802.Q seems like a good idea.

Someone had sent some patches to do PVST, but PVST seems to be Cisco
centric. and the patched version was too inflexible, so I didn't put
it in mainline.



_______________________________________________
Bridge mailing list
Bridge@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/bridge

