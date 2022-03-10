Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ThJhg7Y6Zed5e0dNMLyGm4kfVIWPYT9T3lVpOytMe3c=;
 b=EABUOsH74nrjCWZ3rd8ZuNqM1VulsQ817y/y7YxvUqhpfJuzjYB2EQpSGzn6BR+EO0
 pjM/dm9dJLVHBXtNmKVKbyeOedrs+St7dxELgE62rEDT049uhCRMhHvwhDNk3KMKahJE
 ZCgmti7srzFV9ZlluZ8DQrfm+2T8jAV1h9KYIwAeL97r9f23I+ILkRLlmVnb/gqFCZDk
 vVMwXtijc4lCNQ6pZ011a/XALM2E+oY4zqzr7p7q8dVEDqUjZQOzTpABQhOVVRTA3cVw
 91d1JZIuuq7iOzQGVIG57bg6hXuRgH+Koto8Gcj5o1WwPyX4oaNP44VOBhop1klLfMYy
 QA4w==
Date: Thu, 10 Mar 2022 17:33:53 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220310153353.s6dejcapieltpqpu@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-11-tobias@waldekranz.com>
 <20220303222658.7ykn6grkkp6htm7a@skbuf>
 <87k0d1n8ko.fsf@waldekranz.com>
 <20220310152547.etuov6kpqotnyv2p@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310152547.etuov6kpqotnyv2p@skbuf>
Subject: Re: [Bridge] [PATCH v2 net-next 10/10] net: dsa: mv88e6xxx: MST
	Offloading
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

On Thu, Mar 10, 2022 at 05:25:47PM +0200, Vladimir Oltean wrote:
> > >> +	err = mv88e6xxx_sid_get(chip, attr->orig_dev, vattr->msti, &new_sid);
> > >> +	if (err)
> > >> +		goto unlock;
> > >> +
> > >> +	if (vlan.sid) {
> > >> +		err = mv88e6xxx_sid_put(chip, vlan.sid);
> > >> +		if (err)
> > >> +			goto unlock;
> > >> +	}
> > >> +
> > >> +	vlan.sid = new_sid;
> > >> +	err = mv88e6xxx_vtu_loadpurge(chip, &vlan);
> > >
> > > Maybe you could move mv88e6xxx_sid_put() after this succeeds?
> > 
> > Yep. Also made sure to avoid needless updates of the VTU entry if it
> > already belonged to the correct SID.
> 
> I realize I gave you conflicting advice here, first with inverting the
> refcount_inc() with the refcount_dec(), then with having fast handling
> of noop-changes to vlan.sid. I hope you're able to make some sense out
> of that and avoid the obvious issue with the refcount temporarily
> dropping to zero before going back to 1, which makes the sanity checker
> complain.

Oh wow... I didn't look at the code again, and commented based on a
false memory. Disregard, sorry. You aren't reversing sid_get with sid_put,
nor did I suggest that. There's a lot that happened just in my head,
apparently.
