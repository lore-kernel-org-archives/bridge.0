Return-Path: <vivien.didelot@savoirfairelinux.com>
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
In-Reply-To: <b0b6b46a239eb330d722cea89137ab6ec5bae6e3.1527173527.git.petrm@mellanox.com>
References: <cover.1527173527.git.petrm@mellanox.com>
	<b0b6b46a239eb330d722cea89137ab6ec5bae6e3.1527173527.git.petrm@mellanox.com>
Date: Fri, 25 May 2018 12:17:33 -0400
Message-ID: <877enrzp42.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 6/7] net: bridge: Notify about bridge
	VLANs
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

> A driver might need to react to changes in settings of brentry VLANs.
> Therefore send switchdev port notifications for these as well. Reuse
> SWITCHDEV_OBJ_ID_PORT_VLAN for this purpose. Listeners should use
> netif_is_bridge_master() on orig_dev to determine whether the
> notification is about a bridge port or a bridge.
>
> Signed-off-by: Petr Machata <petrm@mellanox.com>

> +	} else {
> +		err = br_switchdev_port_obj_add(dev, v->vid, flags);
> +		if (err && err != -EOPNOTSUPP)
> +			goto out;
>  	}

Except that br_switchdev_port_obj_add taking vid and flags arguments
seems confusing to me, the change looks good:

Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Thanks,

        Vivien
