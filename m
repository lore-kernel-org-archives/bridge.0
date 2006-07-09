From: Jason Lunz <lunz@falooley.org>
Date: Sun, 9 Jul 2006 18:21:59 +0000 (UTC)
Message-ID: <e8rhg7$262$1@sea.gmane.org>
References: <988346560607082052g6e2eb040s8e578909d1fdd69d@mail.gmail.com>
Sender: news <news@sea.gmane.org>
Subject: Re: [Bridge] Bridging two private lans w/ PPP and brtcl
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

cyberfunk@gmail.com said:
> Hi all, I'm trying to do the following (ASCII art diagram viewable in
> fixed-width font at end of message):
>
> Take 2 private LANs, seperated by the internet, and bridge them by
> creating a bridge from 2 ethernet devices and a ppp interface tunneled
> over ssh between the two linux boxes concerned.

You might want to investigate how openvpn works. In its simplest use,
it's just an implementation of bridging in userspace using tap devices.

Jason

