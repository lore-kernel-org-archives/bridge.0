Return-Path: <kvalo@codeaurora.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1521205285;
	bh=qeJmNS2f9yj3D5UpjgNUKFk2/fda3JhaTjsdcoIFKL8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=l7yfEYD9450EsfoDoxVk3J9PCDVD5noIs7i3CY9LTpdJPDOOYIXOfTr6NlLyONXYJ
	xlr+xrVkZRVKljVmIbg9Wek3DBhL0OfnphyC8hd/+5+5tQxd0A5LfPG/Ralab71or6
	ukIv131NfsbTX7hZ5c03k4cCPUE/xtblwrfwlydA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1521205284;
	bh=qeJmNS2f9yj3D5UpjgNUKFk2/fda3JhaTjsdcoIFKL8=;
	h=Subject:From:In-Reply-To:References:To:Cc:From;
	b=LQKbRM6wQ9e6JrjAagC1VivnrGcVQZVoFaYCi55c9aFG1xRFJn4nUkr8BXwoupDN2
	N2udPlWyynX0UBIXBIN8sNFnZaFhv4St3wl1quoqhD6U+N61nbbvYwnIZTSYukkF+Z
	VY7eu90ko5CslgKwckrvCdV5nB1mlrf40y/ENaXs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180315072909.1512-1-zajec5@gmail.com>
References: <20180315072909.1512-1-zajec5@gmail.com>
Message-Id: <20180316130125.97A8F60C64@smtp.codeaurora.org>
Subject: Re: [Bridge] [V2] brcmfmac: drop Inter-Access Point Protocol
	packets by default
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 16 Mar 2018 13:01:26 -0000
To: =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: James Hughes <james.hughes@raspberrypi.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, netdev@vger.kernel.org, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, brcm80211-dev-list.pdl@broadcom.com, Wright Feng <wright.feng@cypress.com>, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>, Felix Fietkau <nbd@nbd.name>, brcm80211-dev-list@cypress.com, Franky Lin <franky.lin@broadcom.com>

Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Testing brcmfmac with more recent firmwares resulted in AP interfaces
> not working in some specific setups. Debugging resulted in discovering
> support for IAPP in Broadcom's firmwares.
> 
> Older firmwares were only generating 802.11f frames. Newer ones like:
> 1) 10.10 (TOB) (r663589)
> 2) 10.10.122.20 (r683106)
> for 4366b1 and 4366c0 respectively seem to also /respect/ 802.11f frames
> in the Tx path by performing a STA disassociation.
> 
> This obsoleted standard and its implementation is something that:
> 1) Most people don't need / want to use
> 2) Can allow local DoS attacks
> 3) Breaks AP interfaces in some specific bridge setups
> 
> To solve issues it can cause this commit modifies brcmfmac to drop IAPP
> packets. If affects:
> 1) Rx path: driver won't be sending these unwanted packets up.
> 2) Tx path: driver will reject packets that would trigger STA
>    disassociation perfromed by a firmware (possible local DoS attack).
> 
> It appears there are some Broadcom's clients/users who care about this
> feature despite the drawbacks. They can switch it on using a new module
> param.
> 
> This change results in only two more comparisons (check for module param
> and check for Ethernet packet length) for 99.9% of packets. Its overhead
> should be very minimal.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-drivers.git, thanks.

125905517028 brcmfmac: drop Inter-Access Point Protocol packets by default

-- 
https://patchwork.kernel.org/patch/10283971/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

