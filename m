Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1612296411; x=1643832411;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RKeIouPfYkF0dzBJ5Fr1sj32s0c2UpAxGehgP0ipTIk=;
 b=fEMDv/U7p2l/PXmMLP7zlNrs/o01viw7933ENvPoUvjNRRPbMKoRRaBv
 6KfJzzI3dzBz6Di3M8/vc/Ugu0d1r8/S86w24xsoJ4kiKcEiB9gG/Ijyt
 hpVuL1EYmUkd8FkmeoxJzDV4cVTC8D5fFJ9zp64ocmsGGW5poAunzCQro
 0jNO5QdL8oYCsE7QXy1gs3N45R+0sW4g66RCTYM6Bb/dOoKpxiBgiyJTa
 mLSIX90AkyaTurdguc9RebrnmO+PCedxksL0Iok1ow/H/7R3D6Sef4jSh
 FOhx3qlM10DMhtNAX9iQFkQNeQBJaHV/aJG2MLAsk8wrXOp8NxNa7babV g==;
Date: Tue, 2 Feb 2021 21:06:49 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20210202200649.mc7vpgltoqxf2oni@soft-dev3.localdomain>
References: <20210127205241.2864728-1-horatiu.vultur@microchip.com>
 <20210129190114.3f5b6b44@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <9143d15f-c41d-f0ab-7be0-32d797820384@prevas.dk>
 <20210202115032.6affffdc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210202115032.6affffdc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Subject: Re: [Bridge] [PATCH net-next v2 0/4] bridge: mrp: Extend
	br_mrp_switchdev_*
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, davem@davemloft.net

The 02/02/2021 11:50, Jakub Kicinski wrote:
> 
> On Tue, 2 Feb 2021 08:40:02 +0100 Rasmus Villemoes wrote:
> > On 30/01/2021 04.01, Jakub Kicinski wrote:
> > > On Wed, 27 Jan 2021 21:52:37 +0100 Horatiu Vultur wrote:
> > >> This patch series extends MRP switchdev to allow the SW to have a better
> > >> understanding if the HW can implement the MRP functionality or it needs
> > >> to help the HW to run it. There are 3 cases:
> >
> > >> v2:
> > >>  - fix typos in comments and in commit messages
> > >>  - remove some of the comments
> > >>  - move repeated code in helper function
> > >>  - fix issue when deleting a node when sw_backup was true
> > >
> > > Folks who were involved in previous MRP conversations - does this look
> > > good to you? Anyone planning to test?
> >
> > I am planning to test these, but it's unlikely I'll get around to it
> > this week unfortunately.
> 
> Horatiu are you okay with deferring the series until Rasmus validates?
> Given none of this HW is upstream now (AFAIU) this is an awkward set
> to handle. Having a confirmation from Rasmus would make us a little bit
> more comfortable.

It is perfectly fine for me to wait for Rasmus to validate this series.
Also I have started to have a look how to implement the switchdev calls
for Ocelot driver. I might have something by the end of the week, but
lets see.

-- 
/Horatiu
