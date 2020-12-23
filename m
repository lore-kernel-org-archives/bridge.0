Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4ZX/oY/UMh+zpGx1mdoH5h4IbrR1t26jLXfuR6PIHus=;
 b=gUfgl9ha7ZaX82C1DhmTvyl5Reu1sMt8IXJeECjnH1nCWXv+b8NtbsVWmnxpR45HBK
 u4bxL2Hjrv5ljk9QLG6kceFL2lSiJvzcHUANFwblBUWT3clOX5X2Su9S1fZnyLkmLosE
 Xevz3BMSemRImdclS/xbZ5gEmC5fPuPPT1ZeBICtF3oZlQ5KDWllYrJGuLkdF2BUZtEk
 qMZ0/j/o8wazvDsNdoOJpbAYEdSNwIagHJyIuLvxsaFdyMjeKEmStVf0EgviLykkrxZ8
 A6g1OUvG1USwp+UOqpjl1FZ9Fispt91vi8gJeoImli3s9th4KwMk7bEqMrPNjgflgAWU
 WCtQ==
Date: Wed, 23 Dec 2020 17:31:52 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20201223153152.zbzgs63dykehwk5x@skbuf>
References: <20201223022253.2793452-1-sashal@kernel.org>
 <20201223022253.2793452-48-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223022253.2793452-48-sashal@kernel.org>
Subject: Re: [Bridge] [PATCH AUTOSEL 4.14 48/66] bridge: switchdev: Notify
 about VLAN protocol changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sasha Levin <sashal@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, Ivan Vecera <ivecera@redhat.com>, Danielle Ratson <danieller@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>

On Tue, Dec 22, 2020 at 09:22:34PM -0500, Sasha Levin wrote:
> From: Danielle Ratson <danieller@nvidia.com>
> 
> [ Upstream commit 22ec19f3aee327806c37c9fa1188741574bc6445 ]
> 
> Drivers that support bridge offload need to be notified about changes to
> the bridge's VLAN protocol so that they could react accordingly and
> potentially veto the change.
> 
> Add a new switchdev attribute to communicate the change to drivers.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

This looks like a bit of an odd patch to backport?
Are we also going to backport driver changes that make use of this new
switchdev notifier?
