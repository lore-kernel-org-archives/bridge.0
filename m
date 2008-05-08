Message-ID: <4822EE5C.8030404@sysnetsistemi.it>
Date: Thu, 08 May 2008 14:13:16 +0200
From: Francesco Dolcini <fdolcini@sysnetsistemi.it>
MIME-Version: 1.0
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>
	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>
	<4822C20B.3050303@sysnetsistemi.it>
	<1210240896.32216.146.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1210240896.32216.146.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] STP bug, loop not detetcted
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>, bridge@lists.linux-foundation.org

Joakim Tjernlund wrote:
> On Thu, 2008-05-08 at 11:04 +0200, Francesco Dolcini wrote:
>> cisco and others solved this kind of problem using proprietary 
>> unidirectional link detection protocols (see cisco informational rfc 
>> 5171 for example). No standard exists as far as I know (BFD rfc does not 
>> consider the layer 2 case).
> 
> Are these proprietary unidirectional link detection protocols the only
> way to solve the problem?
spanning tree protocol, in the various IEEE incarnation (802.1D, 802.1Q) 
and cisco (PVSTP) does not handle this problem, so an external mechanism 
is needed.

> Would STP break if the interface was set to "non forwarding" in this
> case until the bridge stops seeing its own STP messages?
At least this will not solve the more general problem of a 
unidirectional link (rx working and tx broken).
