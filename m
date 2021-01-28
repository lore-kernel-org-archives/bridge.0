Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611798147;
 bh=4vLfmeyK9AuDFxkUBs0MB1PAHNzPTWLRrZAfsUxxuhY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=f/qYBVMaB8KKg7rQbGniI96CxgU6uiTi1mzhuP+uWQ/h2IW6HVX3RG1+kY2EcEuhy
 jrQbp/jteSR+5EFzqAxiY3erQifVlTyERtWEMf1cyijsf3j+sWvYtyaghDHaFHRo48
 Ap4flzMUqNk0421/SO6YlarmETgB88Ajub0CzItNt3y7SfDVZXty3oX5XyhvUpMeHd
 uUl3umrmGD3qWc8JWD21vbj3gM9hDbBY49McVAwhJOraX6mp3t2FVCY4d1JoGOJTTF
 j4ktdoRstVNqx+h7snM1PoxDuBvCGfDlGFU+YF2JV/wnigZlQ/AuvPOTLkQLek1zJa
 1UkHqc4xBJyrQ==
Date: Wed, 27 Jan 2021 17:42:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20210127174226.4d29f454@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210126093533.441338-1-razor@blackwall.org>
References: <20210126093533.441338-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/2] net: bridge: multicast:
 per-port EHT hosts limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On Tue, 26 Jan 2021 11:35:31 +0200 Nikolay Aleksandrov wrote:
> From: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> Hi,
> This set adds a simple configurable per-port EHT tracked hosts limit.
> Patch 01 adds a default limit of 512 tracked hosts per-port, since the EHT
> changes are still only in net-next that shouldn't be a problem. Then
> patch 02 adds the ability to configure and retrieve the hosts limit
> and to retrieve the current number of tracked hosts per port.
> Let's be on the safe side and limit the number of tracked hosts by
> default while allowing the user to increase that limit if needed.

Applied, thanks!

I'm curious that you add those per-port sysfs files, is this a matter
of policy for the bridge? Seems a bit like a waste of memory at this
point.
