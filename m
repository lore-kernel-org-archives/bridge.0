Return-Path: <davem@davemloft.net>
Date: Mon, 05 Dec 2016 13:27:54 -0500 (EST)
Message-Id: <20161205.132754.1207366793139836952.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1480764803-5577-1-git-send-email-bianpan2016@163.com>
References: <1480764803-5577-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/1] net: bridge: set error code on failure
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bianpan2016@163.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>
Date: Sat,  3 Dec 2016 19:33:23 +0800

> Function br_sysfs_addbr() does not set error code when the call
> kobject_create_and_add() returns a NULL pointer. It may be better to
> return "-ENOMEM" when kobject_create_and_add() fails.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188781
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Applied.
