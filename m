Return-Path: <shemminger@vyatta.com>
Date: Thu, 17 May 2012 09:09:23 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20120517090923.0d0930e9@nehalam.linuxnetplumber.net>
In-Reply-To: <1337270425-21873-1-git-send-email-eldad@fogrefinery.com>
References: <1337270425-21873-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] ipv6: correct the ipv6 option name - Pad0 to
	Pad1
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eldad Zack <eldad@fogrefinery.com>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Jamal Hadi Salim <hadi@cyberus.ca>, James Morris <jmorris@namei.org>, "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org

On Thu, 17 May 2012 18:00:25 +0200
Eldad Zack <eldad@fogrefinery.com> wrote:

> The padding destination or hop-by-hop option is called Pad1 and not Pad0.
> 
> See RFC2460 (4.2) or the IANA ipv6-parameters registry:
> http://www.iana.org/assignments/ipv6-parameters/ipv6-parameters.xml
> 
> Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

If standards bodies want to call a 0 a 1, then I guess we have to follow :-)
