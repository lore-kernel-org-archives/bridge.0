Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=fOag821bdXLm7M8UNvUON4TThlGK1IVCXGCmVyiG5qY=;
	b=Bpw3mnrUaCwSe81p76BCNbMPFbMx4r63WN+h5/fURSdl9z8ljMxdcXtwSmKbltOJyR
	0EWuT1ew7ekCd01e40+b1XsDuQxM8iiM2HjhRCJJfcs9lnWZm6sil6kOwGUjWMUYooqi
	kxZIMG0DR+qvRxKAOejanqBlSVcA4NQunfA0E=
References: <cover.1460131308.git.lucien.xin@gmail.com>
	<6e2cf6821542a253904dfc7d8ec431d6bbda2b4e.1460131308.git.lucien.xin@gmail.com>
	<6197a35a2eb6df2caf90edcbf1b49da12077f659.1460131308.git.lucien.xin@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <5708F604.6080201@cumulusnetworks.com>
Date: Sat, 9 Apr 2016 14:31:00 +0200
MIME-Version: 1.0
In-Reply-To: <6197a35a2eb6df2caf90edcbf1b49da12077f659.1460131308.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCHv3 net-next 2/6] bridge: simplify the
 forward_delay_store by calling store_bridge_parm
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org
Cc: davem@davemloft.net

On 04/08/2016 06:03 PM, Xin Long wrote:
> There are some repetitive codes in forward_delay_store, we can remove
> them by calling store_bridge_parm.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/bridge/br_sysfs_br.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


