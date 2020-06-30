Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593533565;
 bh=owmaLgZhLsBtFwWqdKpAtQq7cNhD5zxKybF7zSfyAVs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PxPvwaOJV4DgQE5vXhGqjfatDncv7xf5K7I9Ksimy5Dnifhpbmm0NVAim0a1Jp4VN
 rnNJRp5a3jN0PZ1fA4MBafFGAwEvS9zD0i8ee589axHp9si4zwB3lsT8JrTx9LQINI
 kNZT28DRdy7g3RhnVh2thCmYHJ0gXPQRcevWOKsM=
Date: Tue, 30 Jun 2020 09:12:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20200630091243.124869e2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200630134424.4114086-3-horatiu.vultur@microchip.com>
References: <20200630134424.4114086-1-horatiu.vultur@microchip.com>
 <20200630134424.4114086-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/3] bridge: mrp: Add br_mrp_fill_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, jiri@mellanox.com, davem@davemloft.net

On Tue, 30 Jun 2020 15:44:23 +0200 Horatiu Vultur wrote:
> Add the function br_mrp_fill_info which populates the MRP attributes
> regarding the status of each MRP instance.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

This adds warnings when built with W=1 C=1:

net/bridge/br_mrp_netlink.c:316:9: warning: dereference of noderef expression
net/bridge/br_mrp_netlink.c:325:36: warning: dereference of noderef expression
net/bridge/br_mrp_netlink.c:328:36: warning: dereference of noderef expression
net/bridge/br_mrp_netlink.c:316:9: warning: dereference of noderef expression
