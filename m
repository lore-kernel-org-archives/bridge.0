Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6703742408
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32870423F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657241048;
 bh=EC7a4jTfAaizoRSMF4FsVpM10jc1Vx60by0MKMOikKI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=J7buxAjoy+adEYbK2ndgRVkdH/bRZQd1xQJ83dKqMYPLqzO7K8SohPXucoAmj7lJw
 lXlK98vnwsMtyUs6cqJvdncgZSM+u8iWNEd84GaJxGEb8JwmJznOQ8diA8yX3EE+9t
 AyBc2jtDAHiy/c9qalzH/C4zpxEfR44rctLToIM/H+o6DzxW+shjErAqPIZ51BH2Tj
 w3PhcIgxKUGzp6rfEjTCNkv8zm+iHrtWRB+8L8NEZ7Mv9xOAjzyEzGVOLdus18aNvi
 qFBhYl1bIalHBXubutm/9Fbfkaocgls6Zfa3BLkpbMVdpgT4B7+bPE8Q+LLXcKle9S
 rXNUZKZHDb9sw==
Date: Thu, 7 Jul 2022 17:43:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220707174358.3b1b804a@kernel.org>
In-Reply-To: <20220707102836.u7ig6rr2664mcrlf@skbuf>
References: <20220706122502.1521819-1-netdev@kapio-technology.com>
 <20220707102836.u7ig6rr2664mcrlf@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/1] net: dsa: mv88e6xxx: allow
 reading FID when handling ATU violations
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu, 7 Jul 2022 13:28:36 +0300 Vladimir Oltean wrote:
> Make no mistake, the existing code doesn't disallow reading back the FID
> during an ATU Get/Clear Violation operation, and your patch isn't
> "allowing" something that wasn't disallowed.
> 
> The documentation for the ATU FID register says that its contents is
> ignored before the operation starts, and it contains the returned ATU
> entry's FID after the operation completes.
> 
> So the change simply says: don't bother to write the ATU FID register
> with zero, it doesn't matter what this contains. This is probably true,
> but the patch needs to do what's written on the box.
> 
> Please note that this only even matters at all for switches with
> mv88e6xxx_num_databases(chip) > 256, where MV88E6352_G1_ATU_FID is a
> dedicated register which this patch avoids writing. For other switches,
> the FID is embedded within MV88E6XXX_G1_ATU_CTL or MV88E6XXX_G1_ATU_OP.
> So _practically_, for those switches, you are still emitting the
> GET_CLR_VIOLATION ATU op with a FID of 0 whether you like it or not, and
> this patch introduces a (most likely irrelevant) discrepancy between the
> access methods for various switches.
> 
> Please note that this observation is relevant for your future changes to
> read back the FID too. As I said here:
> https://patchwork.kernel.org/project/netdevbpf/patch/20220524152144.40527-4-schultz.hans+netdev@gmail.com/#24912482
> you can't just assume that the FID lies within the MV88E6352_G1_ATU_FID
> register, just look at the way it is packed within mv88e6xxx_g1_atu_op().
> You'll need to unpack it in the same way.

I reckon it'll be useful to render some of this info into the commit
message and adjust the subject so marking Changes Requested.
