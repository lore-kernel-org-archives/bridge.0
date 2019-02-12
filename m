Return-Path: <SRS0=5jtu=QT=linuxfoundation.org=gregkh@kernel.org>
Date: Tue, 12 Feb 2019 08:28:47 +0100
From: Greg KH <greg@kroah.com>
Message-ID: <20190212072847.GB2940@kroah.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
	<20190211211749.19847-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211211749.19847-4-f.fainelli@gmail.com>
Subject: Re: [Bridge] [PATCH net-next 3/3] staging: fsl-dpaa2: ethsw: Remove
 getting PORT_BRIDGE_FLAGS
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, netdev@vger.kernel.org, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, vivien.didelot@gmail.com

On Mon, Feb 11, 2019 at 01:17:49PM -0800, Florian Fainelli wrote:
> There is no code that tries to get the attribute
> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS, remove support for doing that.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
