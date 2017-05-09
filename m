Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=VM5a29fqP95S1lJxPMUQbYsDCLKj49ryy4WzRwBltm0=;
	b=YP7lSbEoon+8DAygCdWSk1yRFfssjGAZL1y6hjnyrcEwt8+WOVr/7LzRLlsccRuLUd
	RBVYyOEBqY4CXP+UIcu2tFZNl8uiKTdPa3CYJnYcDyhoO/KEPapnWdrP6bJmWihOscxD
	yDrjPhyIQ4DVOVmYExxc2F5qhuaSKhkDh8W0+wUt2XC9dTwywPuxXdtu+0NCJsBpdOJC
	SYAyhxW9ugkbkYXDj9DXsxXyLh3dXy+5bydmBl9bqFuIr/BmXEKU/o269j7knp8EApIw
	ik9AnM/pWKUJjemyFLq/ZQD1AQTbmy+7Pb1fh/hVBLZlOhDYw7XoZCuJPRlxjlVysI4p
	BbXw==
Date: Tue, 9 May 2017 08:49:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170509084928.4cfcbda5@xeon-e3>
In-Reply-To: <20170509124439.45674-1-fredrik.markstrom@gmail.com>
References: <20170509124439.45674-1-fredrik.markstrom@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/2] net: Set maximum receive packet size on
 veth interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fredrik Markstrom <fredrik.markstrom@gmail.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Tue,  9 May 2017 14:44:36 +0200
Fredrik Markstrom <fredrik.markstrom@gmail.com> wrote:

> Currently veth drops all packets larger then the mtu set on the receiving
> end of the pair. This is inconsistent with most hardware ethernet drivers.

There is no guarantee that packets larger than MTU + VLAN tag will be received
by hardware drivers. So why is this necessary for veth? What is your special
use case which makes this necessary?
