Return-Path: <andrew@lunn.ch>
Date: Sun, 27 Aug 2017 01:02:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20170826230230.GA13622@lunn.ch>
References: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
	<c3f5050f-7a38-c28c-31d0-df5909259fb1@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f5050f-7a38-c28c-31d0-df5909259fb1@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH RFC WIP 0/5] IGMP snooping for local traffic
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, netdev <netdev@vger.kernel.org>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com

> Hi Andrew,
> 
> Have you taken a look at mglist (the boolean, probably needs a rename) ? It is for
> exactly that purpose, to track which groups the bridge is interested in.
> I assume I'm forgetting or missing something here.
> 
> > performed. With a pure software bridge, it is not required. All
> > mulitcast frames are passed to the brX interface, and the network
> 
> If mglist (again the boolean) is false then they won't be passed up.
> 
> > stack filters them, as it does for any interface. However, when
> > hardware offload is involved, things change. We should program the
> > hardware to only send multcast packets to the host when the host has
> > in interest in them.
> 
> Granted the boolean mglist might need some changes (esp. with host group leave)
> but I think it can be used to program switchdev for host join/leave, can't
> we adjust its behaviour instead of introducing this complexity and avoid many
> headaches ?

I would like to avoid this complexity as well. I will take a look at
mglist. Thanks for the hint.

	Andrew
