Return-Path: <joakim.tjernlund@transmode.se>
In-Reply-To: <OFCC73E54C.1D86C779-ONC12579B1.0047DF7C-C12579B1.004CB226@LocalDomain>
References: <OFCC73E54C.1D86C779-ONC12579B1.0047DF7C-C12579B1.004CB226@LocalDomain>
Message-ID: <OF58FCEE11.0E45055D-ONC12579B1.006A93A8-C12579B1.006AEA60@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 27 Feb 2012 20:27:48 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] STP message age broken?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Cc: bridge@lists.linux-foundation.org

Joakim Tjernlund/Transmode wrote on 2012/02/27 14:57:43:
>
> There are problems with STP and its message age calculation even after commit:
>  bridge: send proper message_age in config BPDU
>
> Using HZ=1000 one can see that received msg and transmitted msg age are 0
> going back to HZ=100 it gets better, but still looks strange.
>
> Using HW switches(RSTP) and linux bridge in series:
>   HW Switch(A, master) - HW Switch(B) - Linux BR(C) - Linux BR(D) - Linux BR(E)
> In C we can with tcpdump see that incoming msg age is 1, but
> in D we see incoming msg age 0, should be > 1 (or so I think)
> Then in E we see incoming msg age 2.
>
> Should not msg age increase with at least 1 for every hop?

hmm, Linux bridge seem to add a RELATIVE msg age instead of adding to the received
msg age, that is, if rx msg age is 10 and processing takes 1 then the bridge code sends 1 instead of
11. This seems broken to me.

 Jocke

