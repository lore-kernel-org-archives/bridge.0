From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <4822C20B.3050303@sysnetsistemi.it>
References: <1210152122.32216.95.camel@gentoo-jocke.transmode.se>
	<2e59e6970805071916r701987fdx49bab341420ba2d@mail.gmail.com>
	<1210233718.32216.121.camel@gentoo-jocke.transmode.se>
	<4822C20B.3050303@sysnetsistemi.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 May 2008 12:01:36 +0200
Message-Id: <1210240896.32216.146.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Subject: Re: [Bridge] STP bug, loop not detetcted
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Francesco Dolcini <fdolcini@sysnetsistemi.it>
Cc: Bridge@lists.linux-foundation.org


On Thu, 2008-05-08 at 11:04 +0200, Francesco Dolcini wrote:
> Joakim Tjernlund wrote:
> > On Thu, 2008-05-08 at 02:16 +0000, richardvoigt@gmail.com wrote:
> >> If a bridge receives one of its own STP packets on the same interface
> >> from which it was sent, that indicates a loop elsewhere in the network
> >> that disabling an interface locally will not fix, therefore STP takes
> >> no action.
> > 
> > I see, would it hurt something else if STP did turn off it interface in
> > this case? Optical i/f's is getting more common so these types of loops
> > will increase so I think this needs to be addressed.
> > 
> cisco and others solved this kind of problem using proprietary 
> unidirectional link detection protocols (see cisco informational rfc 
> 5171 for example). No standard exists as far as I know (BFD rfc does not 
> consider the layer 2 case).

Are these proprietary unidirectional link detection protocols the only
way to solve the problem?

Would STP break if the interface was set to "non forwarding" in this
case until the bridge stops seeing its own STP messages?
Seems like the right thing to do.

 Jocke

> 
> I am working on an custom udld protocol implementation at the moment ...
> 
> > Any chance Rapid STP will fix my problem?
> no
> 
