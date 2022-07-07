Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEA19419B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7688340257
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=u0grqM27ho+H910v/3h5J9J38TRWwOJg//0S3hrINWs=;
 b=RAHhsOx1WYQmtl8aJ9hOVmvAwZIviDcDLPraefIX34HzrYSnbauWDMc+Yqo+BVLdyh
 LwEkKsAOts4gLXgoy0A5iOrymg2gs/8WKzG2XOUYQacJh7ZdBXH6foa22vJkKzlvTZ5b
 +DsCgmj+L9EPE8C+/JsopzQ1mCFxOvPnxps0Y7d1C0nrdCcIuEAf4dg/bQypJGb8cboP
 HN6YdHbnv4keOK8vrE2+S4MAPTglkdBFoO7FtPj2XJc6mhCLwotN1ZXOqYPY/h1GSvUz
 GtmZo0ghamPkXVVsyRA88+po3U/bJecBzDVDnN7H2rfb83us2v18GQdwvgdqEiVjQ2e9
 C4xw==
Date: Thu, 7 Jul 2022 13:28:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220707102836.u7ig6rr2664mcrlf@skbuf>
References: <20220706122502.1521819-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706122502.1521819-1-netdev@kapio-technology.com>
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Wed, Jul 06, 2022 at 02:25:02PM +0200, Hans Schultz wrote:
> For convenience the function mv88e6xxx_g1_atu_op() has been used to read
> ATU violations, but the function has other purposes and does not enable
> the possibility to read the FID when reading ATU violations.
> 
> The FID is needed to get hold of which VID was involved in the violation,
> thus the need for future purposes to be able to read the FID.

Make no mistake, the existing code doesn't disallow reading back the FID
during an ATU Get/Clear Violation operation, and your patch isn't
"allowing" something that wasn't disallowed.

The documentation for the ATU FID register says that its contents is
ignored before the operation starts, and it contains the returned ATU
entry's FID after the operation completes.

So the change simply says: don't bother to write the ATU FID register
with zero, it doesn't matter what this contains. This is probably true,
but the patch needs to do what's written on the box.

Please note that this only even matters at all for switches with
mv88e6xxx_num_databases(chip) > 256, where MV88E6352_G1_ATU_FID is a
dedicated register which this patch avoids writing. For other switches,
the FID is embedded within MV88E6XXX_G1_ATU_CTL or MV88E6XXX_G1_ATU_OP.
So _practically_, for those switches, you are still emitting the
GET_CLR_VIOLATION ATU op with a FID of 0 whether you like it or not, and
this patch introduces a (most likely irrelevant) discrepancy between the
access methods for various switches.

Please note that this observation is relevant for your future changes to
read back the FID too. As I said here:
https://patchwork.kernel.org/project/netdevbpf/patch/20220524152144.40527-4-schultz.hans+netdev@gmail.com/#24912482
you can't just assume that the FID lies within the MV88E6352_G1_ATU_FID
register, just look at the way it is packed within mv88e6xxx_g1_atu_op().
You'll need to unpack it in the same way.
