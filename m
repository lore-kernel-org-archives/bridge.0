Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645633226;
 bh=iwzxRJ3WVWy1eMmDfafaRhAbMtXzmT+t5EvSTlNcAhw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=g4BRZ7ssHQH3BTFNVPjOS3ckd3nmgvpjeaE6eLm4+XUXP0p5axjNrcGTtMfzhmrq7
 Nhcbf3g9R8hNq0paOiE1nVkEqAotlMxe0EaQZQadN0Uhz+KTv7PmTPenDkuPRDcuQR
 Tt1uJZ4G4Kq6w+taKyNr/4T9SwKhCu8dSVdDotMfP28fc1ubQRb7y84aXgqkPWSaLi
 9fl+THewyu4XI3Mmd4yN5JxIfYW9UzLW+ETSwyjh2IAtNPq2MhczbUAgXaxV6LgxEV
 N1JZPlcngeU5p4x7XKaQM51n98/bb2knKdm8kOW7TlJOqAK2PEQ2IiLNdXp7jQPJZJ
 h1T0z0snwRKCQ==
Date: Wed, 23 Feb 2022 08:20:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220223082024.6ab51265@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <86y222vuuc.fsf@gmail.com>
References: <20220222132818.1180786-1-schultz.hans+netdev@gmail.com>
 <20220222111523.030ab13d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <86y222vuuc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 0/5] Add support for locked bridge
 ports (for 802.1X)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Stephen Suryaputra <ssuryaextr@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Wed, 23 Feb 2022 09:40:59 +0100 Hans Schultz wrote:
> > You still haven't answer my question. Is the data plane clear text in
> > the deployment you describe?  
> 
> Sorry, I didn't understand your question in the first instance. So as
> 802.1X is only about authentication/authorization, the port when opened
> for a host is like any other switch port and thus communication is in
> the clear.

Alright, thanks for clarifying!

> I have not looked much into macsec (but know ipsec), and that is a
> crypto (key) based connection mechanism, but that is a totally different
> ballgame, and I think it would for most practical cases require hardware 
> encryption.
