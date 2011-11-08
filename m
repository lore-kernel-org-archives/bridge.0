Return-Path: <m.fornasa.dei@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=sender:message-id:date:from:user-agent:mime-version:to:subject
	:content-type:content-transfer-encoding;
	bh=EnFiwkcguUWlxJ7RTh+dB3xaC79lvovWygH4S81AXOM=;
	b=EumYWz0CUFcznDfnIW3C2zqjhxAgO4Dp1y+SRty4Kx6Ob6OUTkUm6OdYxSTB3ybCLW
	sXjlIARHKqSpqCHkJcp0bEvrF7FRu+SK6Nsgdnh/nfQG8SUSphnJGNoQuK1Jurx93SJZ
	17oE8/pKITBaDhUcGFlajf7v/OQNkoF7l6ojI=
Sender: Martino Fornasa <m.fornasa.dei@gmail.com>
Message-ID: <4EB8F874.8090408@cipi.unige.it>
Date: Tue, 08 Nov 2011 10:37:56 +0100
From: Martino Fornasa <m.fornasa@cipi.unige.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] RSTP implementation status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all.
I'm interested in RSTP implementation (and maybe in contributing to it).

I read this 
[http://lkml.indiana.edu/hypermail/linux/net/0807.1/0011.html] message, 
and I had a look on the ongoing RSTP project hosted at 
[https://github.com/shemminger/RSTP]. Is this project still running?

I noticed that such a ongoing project is based on rstplib 
[http://rstplib.sourceforge.net/]. By taking a brief look at the code, 
it seems to me that such a code is based on the obsolete 802.1w 
specification, while the newest specification for RSTP is contained in 
802.1D-2004; and such a specification (beside incorporating 
compatibility with STP) is radically different from 802.1w (e.g., 
different set of states on state machines...), and it is not easy to 
understand the amount of interoperability between the two.

I think that a serious issue in implementing network bridging/routing 
protocols is to proper validate and testing it. For example, I know that 
there are companies that offer commercial validation system for network 
protocol. As some RSTP implementations as been put in the past in the 
kernel, and STP is already in it, are such implementations have been 
tested and validated? How?

B.R., Martino Fornasa.

