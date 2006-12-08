Date: Fri, 8 Dec 2006 07:17:15 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061208071715.67d18616@localhost.localdomain>
In-Reply-To: <34d8b2fe0612080119v5989fe08m800137d27b9f9508@mail.gmail.com>
References: <34d8b2fe0612070918k63845693hd57936ad17e2e53b@mail.gmail.com>
	<ec7cefb0612071133r8117db8m1db014f1e2783f6e@mail.gmail.com>
	<ec7cefb0612071831k18cf1839xe4185c268254b1d7@mail.gmail.com>
	<34d8b2fe0612080119v5989fe08m800137d27b9f9508@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Help needed about IP class finding in a bridge
 netfilter module
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Louis Croisez <louis.croisez@gmail.com>
Cc: bridge@lists.osdl.org

On Fri, 8 Dec 2006 10:19:57 +0100
"Louis Croisez" <louis.croisez@gmail.com> wrote:

> Hi Eric,
> first, thx for your responses.
> I have tried to hping on destination IP 239.255.255.250 (a Multicast
> ip used for example in the uPnP discovery process).
> The inet_addr_type() function detect multicast well.
> 
> For the question of the broadcast, your idea of using the mac dest
> address is great. I will check this and give a feedback.
> Cheers,
> LOUIS

You could also look at the destination ethernet address using
	is_multicast_ether_addr()
and     is_broadcast_ether_addr()
