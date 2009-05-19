Message-ID: <4A1296ED.3030801@epfl.ch>
Date: Tue, 19 May 2009 13:24:29 +0200
From: Alexandre Becholey <alexandre.becholey@epfl.ch>
MIME-Version: 1.0
References: <4A11714A.2000301@epfl.ch>
	<2e59e6970905181635h3a4da749ue75574633ff75f5e@mail.gmail.com>
In-Reply-To: <2e59e6970905181635h3a4da749ue75574633ff75f5e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] network bridging between wireless and wired connection
 fails Cont'd
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: "bridge@osdl.org" <bridge@osdl.org>

Hi thanks for your reply.

# brctl showmacs br0
port no    mac addr        is local?    ageing timer
  2    00:14:2d:21:99:2a    no           0.78             (<- PC1's mac)
  1    00:1b:38:e8:51:1c    no           5.75             (<- PC2's mac)
  1    00:21:e9:e7:ae:88    yes           0.00            (<- wlan0)
  2    00:22:41:30:92:18    yes           0.00            (<- eth1)

ifconfig shows that br0 has wlan0's mac address. If a use another 
wireless interface with a "higher" mac address, br0 has eth1's mac address

No iptables nor ebtables running.

Alexandre


richardvoigt@gmail.com wrote:
> What is the output of "brctl br0 showmacs" ?
>
> Are you running iptables or ebtables?
