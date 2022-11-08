Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3935081761
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 462B18176D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/YbHJ4ibpE0FQ4BHuZdNaBU3FcOkLHnK8mt3jJ2tQt8=;
 b=KTfLvqiSu2CcpT1y/20uKajI43NPbw82QWz6SxA0Lir3LFhIVCreDjd17jJiA/SaGm
 AcNAaQpUcrMIX7H5HInQwsM5uEUZ0BBQLzmufcqbGiTPMcWhxrQoIimZtNeNWLUPx3v3
 OkgdSlwRJ4mo9VjQEUIKVbPM8olU9MN+RaF/55nEuHtdh33jvWV0N8Lmj9U77VXBULcd
 mB8r4PzXH87nFtyZ3ALFRNfdqWB8ek/SBpF5rzG5YrYyYUdagOxSQmM5EAn+KYYr/YAp
 UE4AJCRu1+MuxTMDHIj0AossrJjIZpLvMrDrtpNUi88EfacEokhe7sbj/tiZOYhS0GVd
 A1OQ==
Date: Tue, 8 Nov 2022 16:38:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221108143801.42rqnrtprjxurgqh@skbuf>
References: <cover.1667902754.git.petrm@nvidia.com>
 <cover.1667902754.git.petrm@nvidia.com>
 <ec42c7bf37d9a5e05096c409dd96c1c582747b24.1667902754.git.petrm@nvidia.com>
 <ec42c7bf37d9a5e05096c409dd96c1c582747b24.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec42c7bf37d9a5e05096c409dd96c1c582747b24.1667902754.git.petrm@nvidia.com>
 <ec42c7bf37d9a5e05096c409dd96c1c582747b24.1667902754.git.petrm@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 04/15] devlink: Add packet traps for
 802.1X operation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>, Eric Dumazet <edumazet@google.com>, mlxsw@nvidia.com, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Nov 08, 2022 at 11:47:10AM +0100, Petr Machata wrote:
> The "locked_port" drop trap can be enabled to gain visibility into
> packets that were dropped by the device due to the locked bridge port
> check.

Pretty cool.

The action of all devlink DROP traps can be changed to e.g. CONTROL, right?
This doesn't functionally affect an offloading driver, because what
won't be dropped in hw on a locked port will still be dropped by the
bridge, correct?

I'm not familiar with devlink traps. Is there another way to see the
dropped packets except to do what I said (change the action type)?
