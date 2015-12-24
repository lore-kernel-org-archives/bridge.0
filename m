Return-Path: <davem@davemloft.net>
Date: Wed, 23 Dec 2015 22:27:24 -0500 (EST)
Message-Id: <20151223.222724.1927138905231368806.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <544026a4b733db9633610b0744ec99075788157a.1450874224.git.geliangtang@163.com>
References: <2e7e038ba8b7872e9e510aecde073bf944924a51.1450874224.git.geliangtang@163.com>
	<2e7e038ba8b7872e9e510aecde073bf944924a51.1450874224.git.geliangtang@163.com>
	<544026a4b733db9633610b0744ec99075788157a.1450874224.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/2] bridge: use kobj_to_dev instead of to_dev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: geliangtang@163.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: Geliang Tang <geliangtang@163.com>
Date: Wed, 23 Dec 2015 20:42:21 +0800

> kobj_to_dev has been defined in linux/device.h, so I replace to_dev
> with it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Applied.
