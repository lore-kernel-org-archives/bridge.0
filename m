Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8YmlWNGsIRtVtoKHI
 ISw4bcjX7NWo7BrkPWPL8sPzOM=; b=O8QN/sSGleDt1HvNr2/Y+K9PT6s0BDSKR
 mcCNBALC+aTs44bOc3VLq3C+OY9+gi9DF6h8Us3C8O/EBjqatncIrQTALhyDCjBM
 G1j58Lpr6W+KNPWF5mbAC4nXS48jxi7b+iURc9jimwi6DF7KJkDd3CAZF/JLWGVy
 hzM/cRTGj/Vl2L19xsfLBM+XmoiS7aojOZO1dR4mG463ql+FSSQ1u1jJJ+hDhVke
 Ltiyn9ivIW/OxDeYTsDRjeLuqIXsYZck2YMoUKqz9kpekH/pvw/FxaDwXkVPhcUy
 UlW8c68jsSAjnDKKPkGbi9rNM3Pxy0sGkBa8V9SqyR4p8GP6HNeBQ==
Date: Sun, 20 Feb 2022 11:18:28 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YhIHZBXodzr6bk0c@shredder>
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-2-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218155148.2329797-2-schultz.hans+netdev@gmail.com>
Subject: Re: [Bridge] [PATCH net-next v3 1/5] net: bridge: Add support for
 bridge port in locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Stephen Suryaputra <ssuryaextr@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Fri, Feb 18, 2022 at 04:51:44PM +0100, Hans Schultz wrote:
> In a 802.1X scenario, clients connected to a bridge port shall not
> be allowed to have traffic forwarded until fully authenticated.
> A static fdb entry of the clients MAC address for the bridge port
> unlocks the client and allows bidirectional communication.
> 
> This scenario is facilitated with setting the bridge port in locked
> mode, which is also supported by various switchcore chipsets.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>

With Nik's comment fixed:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
