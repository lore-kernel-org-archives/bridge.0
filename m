Return-Path: <davem@davemloft.net>
Date: Mon, 01 Jun 2020 11:56:28 -0700 (PDT)
Message-Id: <20200601.115628.932125543367472654.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200530180948.1194569-1-horatiu.vultur@microchip.com>
References: <20200530180948.1194569-1-horatiu.vultur@microchip.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/3] bridge: mrp: Add support for
	MRA role
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: horatiu.vultur@microchip.com
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sat, 30 May 2020 18:09:45 +0000

> This patch series extends the MRP with the MRA role.
> A node that has the MRA role can behave as a MRM or as a MRC. In case there are
> multiple nodes in the topology that has the MRA role then only one node can
> behave as MRM and all the others need to be have as MRC. The node that has the
> higher priority(lower value) will behave as MRM.
> A node that has the MRA role and behaves as MRC, it just needs to forward the
> MRP_Test frames between the ring ports but also it needs to detect in case it
> stops receiving MRP_Test frames. In that case it would try to behave as MRM.
> 
> v2:
>  - add new patch that fixes sparse warnings
>  - fix parsing of prio attribute

Series applied, thank you.
