From: Uli Luckas <luckas@musoft.de>
Date: Sun, 30 Nov 2008 17:27:43 +0100
References: <282915.85653.qm@web8807.mail.in.yahoo.com>
	<49213FC5.4040001@sysnetsistemi.it>
In-Reply-To: <49213FC5.4040001@sysnetsistemi.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200811301727.44483.luckas@musoft.de>
Subject: Re: [Bridge]
	=?iso-8859-1?q?Bridge_ports_needlessly_going_through_lea?=
	=?iso-8859-1?q?rning_stage_when=09STP_is_disabled?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org
Cc: Stephen Hemminger <shemminger@vyatta.com>, rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>

Am Monday, 17. November 2008 schrieb Francesco Dolcini:
> rahul bhardwaj wrote:
> > Is this the right behavior ? The 15 to 30 second delay before the
> > port moves to Forwarding state can be frustrating, as you don't
> > expect it, and for that period of time, start to think there is
> > something else wrong in the network's configuration. Is there any
> > place in the code where I do some change to resolve this issue.
>
> At the moment the normal way to handle this is "brctl setfd $BR_DEV 0"
>
Except that setting fd to zero might get you flooded. See thread "delay in=
=20
bridge learning when forward delay is 0" here on the list. [1]=20

regards,
Uli


[1] http://archives.free.net.ph/message/20081013.181016.4cbfa529.de.html

=2D-=20
> Ich habe Zone Alarm in Hintergrund mitlaufen, das ist fuer mich
> Pflicht.
Ich habe eine Sch=FCssel Weihwasser neben der Tastatur stehen. Das hilft
genauso.      (J=FCrgen Schmadlak)
