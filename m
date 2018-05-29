Return-Path: <vivien.didelot@savoirfairelinux.com>
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
In-Reply-To: <85401f20b801fa1bae3025bf1df991a9d475fe85.1527519997.git.petrm@mellanox.com>
References: <cover.1527519997.git.petrm@mellanox.com>
	<85401f20b801fa1bae3025bf1df991a9d475fe85.1527519997.git.petrm@mellanox.com>
Date: Tue, 29 May 2018 08:42:40 -0400
Message-ID: <878t82r5tr.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next v3 1/7] net: bridge: Extract
	boilerplate around switchdev_port_obj_*()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net

Hi Petr,

Petr Machata <petrm@mellanox.com> writes:

> A call to switchdev_port_obj_add() or switchdev_port_obj_del() involves
> initializing a struct switchdev_obj_port_vlan, a piece of code that
> repeats on each call site almost verbatim. While in the current codebase
> there is just one duplicated add call, the follow-up patches add more of
> both add and del calls.
>
> Thus to remove the duplication, extract the repetition into named
> functions and reuse.
>
> Signed-off-by: Petr Machata <petrm@mellanox.com>

Considering Dan's comment as well:

Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Thanks,

        Vivien
