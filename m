Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Jx8eZ/jgrSE5jtq/IeRwHlPFovNus3LfRlDhg1AW13A=;
 b=en9t2M3R/YDinK1EfneMzgv5fnKSDbV2GexbGi8qUVmwTSDoEp15UHwZA/M2o65vTS
 1amV/o9IYHjiDxmjxen42QPAkYKpPfbSgHnHpSavW1XfsTw58PopoiG6cKAbBHAUIh80
 Z9vXf90FSFzOih7QWrwZWVuvpsy21CRZGjywUCXNukoL5p8tTEzXYMkVKhBYpK7eeQp1
 iB71j6/AwNLOcWKUYtR2hDgFxCZC/LqpqjPme7lTy8Lh7Q6qlP0sr34zBSPk7aMnM/gD
 TaZi52W9EXR5i0OekbRJVPsXfV+ELpeg9leOt1TkHdfXLGOy0pvBzQ4B3q69dCXgfx6T
 Y+XA==
Date: Tue, 1 Mar 2022 18:21:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220301162142.2rv23g4cyd2yacbs@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301100321.951175-1-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v2 net-next 00/10] net: bridge: Multiple
	Spanning Trees
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

Hi Tobias,

On Tue, Mar 01, 2022 at 11:03:11AM +0100, Tobias Waldekranz wrote:
> A proposal for the corresponding iproute2 interface is available here:
> 
> https://github.com/wkz/iproute2/tree/mst

Please pardon my ignorance. Is there a user-mode STP protocol application
that supports MSTP, and that you've tested these patches with?
I'd like to give it a try.
