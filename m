DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	bh=XmM5WlvGzPtCqpgCXYL41GTVT3MljZkqp2GaIgaHECg=;
	b=NGoqaSAm/DWMdyCTL5moUJxkxrbA8aXdL1211sTwrpLOktZv7TKeoZew/Stu0APvUi7zwWQmv722/nFEvcVyRRhtbBaNVheeHZ+01OoGfVs3BjkDKxCyFSzbeE20y0skT7FCHXPUH1ALYpSc7fwHxTD0cLrU85sB/EjtXZps20U=
Message-ID: <4b1890f00711160128r735bd07aqbf98c499fc157a7a@mail.gmail.com>
Date: Fri, 16 Nov 2007 10:28:44 +0100
From: "IO te" <armbigendian@gmail.com>
Subject: Re: [Bridge] STP and Madwifi problems
In-Reply-To: <20071113090652.0c21b090@freepuppy.rosehill>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4b1890f00711130459x57bab995l90ec2c8e31265612@mail.gmail.com>
	<20071113090652.0c21b090@freepuppy.rosehill>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org

Hi Stephen, sorry for the delay. We have enabled stp first, with no luck...
The same configuration works fine on ethernet, perhaps there's a
problem on using wireless interfaces...

2007/11/13, Stephen Hemminger <shemminger@linux-foundation.org>:
> On Tue, 13 Nov 2007 13:59:08 +0100
> "IO te" <armbigendian@gmail.com> wrote:
>
> > Hi,
> > today we've tested the bridge-utils (kernel 2.6.15) STP in the
> > following scenario using the madwifi 0.9.3.2:
> >
> >         AP    ch. 36     Sta
> >           |----------------------|
> > BR1 |                              | BR2
> >           |----------------------|
> >           Sta   ch. 40     AP
> >
> > Unfortunately it doesn't work because every port of both the boards
> > remains in forwarding state.
> >
> > We were expecting that one of the four ports would move to the blocking state.
> > Obviously one of the two board is elected as root by STP and has both
> > ports in forwarding state, the problem is on the other one.
> >
> > Anyway, these are the configurations:
> >
> > Board 1:
> >
> > wlanconfig ath0 create wlandev wifi0 wlanmode ap
> > iwpriv ath0 mode 1
> > iwconfig ath0 essid tratta1 channel 36
> > iwpriv ath0 wds 1
> > ifconfig ath0 0.0.0.0 up
> > wlanconfig ath1 create wlandev wifi1 wlanmode sta nosbeacon
> > iwpriv ath1 mode 1
> > iwconfig ath1 essid tratta2
> > iwpriv ath1 wds 1
> > ifconfig ath1 0.0.0.0 up
> > brctl addbr br0
> > brctl addif br0 ath0
> > brctl addif br0 ath1
> > ifconfig br0 11.0.0.1/24 up
> > brctl stp br0 on
> >
> > Board 2:
> >
> > wlanconfig ath0 create wlandev wifi0 wlanmode ap
> > iwpriv ath0 mode 1
> > iwconfig ath0 essid tratta2 channel 40
> > ifconfig ath0 0.0.0.0 up
> > wlanconfig ath1 create wlandev wifi1 wlanmode sta nosbeacon
> > iwpriv ath1 mode 1
> > iwconfig ath1 essid tratta1
> > iwpriv ath1 wds 1
> > ifconfig ath1 0.0.0.0 up
> > brctl addbr br0
> > brctl addif br0 ath0
> > brctl addif br0 ath1
> > ifconfig br0 11.0.0.2/24 up
> > brctl stp br0 on
> >
> > The interfaces associate in the right way, but this is the result of
> > the command brctl showstp br0:
> >
> > Board 1:
> >
> > # brctl showstp br0
> > br0
> >  bridge id              8000.00026f408483
> >  designated root        8000.00026f408483
> >  root port                 0                    path cost                  0
> >  max age                  20.00                 bridge max age            20.00
> >  hello time                2.00                 bridge hello time          2.00
> >  forward delay            15.00                 bridge forward delay      15.00
> >  ageing time             300.00
> >  hello timer               0.35                 tcn timer                  0.00
> >  topology change timer     0.00                 gc timer                   0.07
> >  flags
> >
> >
> > ath0 (0)
> >  port id                0000                    state                forwarding
> >  designated root        8000.00026f408483       path cost                100
> >  designated bridge      8000.00026f408483       message age timer          0.00
> >  designated port        8001                    forward delay timer        0.00
> >  designated cost           0                    hold timer                 0.34
> >  flags
> >
> > ath1 (0)
> >  port id                0000                    state                forwarding
> >  designated root        8000.00026f408483       path cost                100
> >  designated bridge      8000.00026f408483       message age timer          0.00
> >  designated port        8002                    forward delay timer        0.00
> >  designated cost           0                    hold timer                 0.00
> >  flags
> >
> > Board 2:
> >
> > # brctl showstp br0
> > br0
> >  bridge id              8000.00156d539d8d
> >  designated root        8000.00026f408483
> >  root port                 1                    path cost                100
> >  max age                  20.00                 bridge max age            20.00
> >  hello time                2.00                 bridge hello time          2.00
> >  forward delay            15.00                 bridge forward delay      15.00
> >  ageing time             100.00
> >  hello timer               0.00                 tcn timer                  0.00
> >  topology change timer     0.00                 gc timer                   0.08
> >  flags
> >
> >
> > ath0 (0)
> >  port id                0000                    state                forwarding
> >  designated root        8000.00026f408483       path cost                100
> >  designated bridge      8000.00026f408483       message age timer         19.70
> >  designated port        8002                    forward delay timer        0.00
> >  designated cost           0                    hold timer                 0.00
> >  flags
> >
> > ath1 (0)
> >  port id                0000                    state                forwarding
> >  designated root        8000.00026f408483       path cost                100
> >  designated bridge      8000.00156d539d8d       message age timer          0.00
> >  designated port        8002                    forward delay timer        0.00
> >  designated cost         100                    hold timer                 0.69
> >  flags
> >
> >
> > Thanks in advance for all your help
> >
> > Andrea, Massimiliano and Riccardo
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/bridge
>
> Are the multicast spanning tree packets making it from bridge to bridge?
> You probably want to enable stp first.
>
> --
> Stephen Hemminger <shemminger@linux-foundation.org>
>
