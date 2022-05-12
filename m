Return-Path: <roopa@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQpYRO1+6eFq0KppbJfNxPGOqDRB8zRvxncEAqpl1Wc=;
 b=gQ4ja7fE+BYWfCJ36Jni1QjGkCAgLTxelDV+RSpJ2p3FW05e70bw3xQypjPJWswdCljvZ0MfOk25S8KHwom8z6qvB1YQN2tX25hTKnbpyFDuj7jR98UX109j5a773jelQdZBLLDwBkoAUDSvwUHzXVspOtogYQIzUhPF5r0ny409bunHqWbyCaKVooKOzySbpy50RrVw8TxeA4fI1q0WUc9XfxIlTThggiU6jrZvdjnKouygTmCQSPhNgCkce9ldvld778+InkKsfGao8JWmxrz7eLsfKbrVVwvJuKh9hJ2pezFQQ89AjpM2r800w3tv7S7Qj4cRGM8/s239QG38gg==
Message-ID: <c6b41db9-78e7-e752-3945-29c70a3d8cb4@nvidia.com>
Date: Thu, 12 May 2022 10:17:13 -0700
Content-Language: en-US
References: <cover.1652348961.git.eng.alaamohamedsoliman.am@gmail.com>
 <c6069fb695b25dc2f33e8017023ddd47c58caa8d.1652348962.git.eng.alaamohamedsoliman.am@gmail.com>
 <c5ec2677-3047-8a70-9769-d48a79703220@nvidia.com>
 <20220512094743.79f36d81@kernel.org>
From: Roopa Prabhu <roopa@nvidia.com>
In-Reply-To: <20220512094743.79f36d81@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v7 2/2] net: vxlan: Add extack support
 to vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com


On 5/12/22 09:47, Jakub Kicinski wrote:
> On Thu, 12 May 2022 09:22:17 -0700 Roopa Prabhu wrote:
>> On 5/12/22 02:55, Alaa Mohamed wrote:
>>> This patch adds extack msg support to vxlan_fdb_delete and vxlan_fdb_parse.
>>> extack is used to propagate meaningful error msgs to the user of vxlan
>>> fdb netlink api
>>>
>>> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> Also the patches don't apply to net-next, again.

that's probably because the patches were already applied. Ido just told 
me abt it also

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=5dd6da25255a9d64622c693b99d7668da939a980

I have requested Alaa send an incremental fix (offline).

thanks

