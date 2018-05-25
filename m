Return-Path: <vivien.didelot@savoirfairelinux.com>
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
In-Reply-To: <56beb523d39852fa30e8e90e80638b0ec917b96a.1527173527.git.petrm@mellanox.com>
References: <cover.1527173527.git.petrm@mellanox.com>
	<56beb523d39852fa30e8e90e80638b0ec917b96a.1527173527.git.petrm@mellanox.com>
Date: Fri, 25 May 2018 12:11:58 -0400
Message-ID: <87a7snzpdd.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 4/7] dsa: port: Ignore bridge VLAN
	events
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

> Ignore VLAN events where the orig_dev is the bridge device itself.
>
> Signed-off-by: Petr Machata <petrm@mellanox.com>

Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Thanks,

        Vivien
