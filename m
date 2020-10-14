Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602717372;
 bh=2d5aAUYPl3e685Wtq1LeFikIS8MayVnNbjd2tNE9i9Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Iz0fyNozvpie0bXmK4hoQHzraMjPyvp0QW3mT+3Ti1faJvaOcW4gPqXzwNQDry8H9
 1jEo7vI+K2S5eYyq7wsBzWOMzYPR4JlNlRupwiohEtd7jWV93etZ2WSyn/G390H6ys
 sf5oPSzHY+NMmEr2hFe3iQ/iPJMKNpVoAYaQsoAI=
Date: Wed, 14 Oct 2020 16:16:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201014161610.46dd5785@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201012140428.2549163-7-henrik.bjoernlund@microchip.com>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-7-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 06/10] bridge: cfm: Kernel space
 implementation of CFM. CCM frame RX added.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

On Mon, 12 Oct 2020 14:04:24 +0000 Henrik Bjoernlund wrote:
> +struct br_cfm_status_tlv {
> +	__u8 type;
> +	__be16 length;
> +	__u8 value;
> +};

This structure is unused (and likely not what you want, since it will
have 2 1 byte while unless you mark length as __packed).
