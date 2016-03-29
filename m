Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=tLZkh2mxa3H+KLEnwon/siPAv0g4ULEph/7FDqLm9ZU=;
	b=HuQo1o5626PLdUYTW8fzQpsmdIZX3IvNYeSETbXY7xgGV9Xoeq1wnn04RBt7cpN3dLtgGliSRfI058NgmENPypK7FmMUuGPqfDqsFiBxuG2WJjDH3UlsNlfDCXdOY6+RnhIvNGBCSFSk59yYAH/vS5IOkiGEXnZ1jBhn+lMnmMs=
Date: Wed, 30 Mar 2016 00:34:13 +0300
From: Ido Schimmel <idosch@mellanox.com>
Message-ID: <20160329213413.GA2917@colbert.idosch.org>
References: <1459248488-25621-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1459248488-25621-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
Subject: Re: [Bridge] [PATCH] bridge: Allow set bridge ageing time when
 switchdev disabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

Tue, Mar 29, 2016 at 01:48:08PM IDT, yanhaishuang@cmss.chinamobile.com wrote:
>When NET_SWITCHDEV=n, switchdev_port_attr_set will return -EOPNOTSUPP,
>we should ignore this error code and continue to set the ageing time.
>
>Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Fixes: c62987bbd8a1 ("bridge: push bridge setting ageing_time down to switchdev")
Acked-by: Ido Schimmel <idosch@mellanox.com>

Thank you.
