Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rr7CeS
 p57r9ki00p083nmHdZkD08g6VJi3ri00zZGDg=; b=TJMJ1jHafr/rpl5PIceP9q
 syX1rFXmkISdPiVMX9dqujREkYRULEbmsqU90X3Bbq7qxLzzn4f1qDUJE140/4fe
 MK76iEmixKYC8bFbdT1tXWA+Z9np2r9A3KBdivaCe4cRNjx7347E+6JDn7jiira5
 jrNAEImAAyM+5YY/Il14GIOhSthVusUg4TP/6nfUDSsBwxvkSzX9i1W6/C925LUe
 H796xg1O0+s0TM7bulf5cafrAuKHwopqbiK8AXSEJ56tJs3ohc03akO3ODRqa6c8
 0hbs03IdDwF325+Qwvrc7v8XxDRA5Ey+UxBC9ugdyy/9odCvHGPGcMkdBmgzeY4A
 ==
Date: Tue, 20 Jul 2021 17:51:24 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YPbi7NSsdDEdvmcA@shredder>
References: <20210720134655.892334-1-vladimir.oltean@nxp.com>
 <YPbXTKj4teQZ1QRi@shredder> <20210720141200.xgk3mlipp2mzerjl@skbuf>
 <YPbcxPKjbDxChnlK@shredder> <20210720144617.ptqt5mqlw5stidep@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720144617.ptqt5mqlw5stidep@skbuf>
Subject: Re: [Bridge] [PATCH v5 net-next 00/10] Let switchdev drivers
 offload and unoffload bridge ports at their own convenience
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Vivien Didelot <vivien.didelot@gmail.com>, DENG Qingfang <dqfext@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Marek Behun <kabel@blackhole.sk>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Tue, Jul 20, 2021 at 02:46:18PM +0000, Vladimir Oltean wrote:
> On Tue, Jul 20, 2021 at 05:25:08PM +0300, Ido Schimmel wrote:
> > If you don't want to change the order, then at least make the
> > replay/cleanup optional and set it to 'false' for mlxsw. This should
> > mean that the only change in mlxsw should be adding calls to
> > switchdev_bridge_port_offload() / switchdev_bridge_port_unoffload() in
> > mlxsw_sp_bridge_port_create() / mlxsw_sp_bridge_port_destroy(),
> > respectively.
> 
> I mean, I could guard br_{vlan,mdb,fdb}_replay() against NULL notifier
> block pointers, and then make mlxsw pass NULL for both the atomic_nb and
> blocking_nb.
> 
> But why? How do you deal with a host-joined mdb that was auto-installed
> while there was no port under the bridge?

mlxsw does not currently support such entries. It's on my TODO list.
When we add support for that, we will also take care of the replay.

> How does anyone deal with that? What's optional about it? Why would
> driver X opt out of it but Y not (apart for the case where driver X
> does not offload MDBs at all, that I can understand).
