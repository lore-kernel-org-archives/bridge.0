Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=K95fyA3TH7xIuWsCapbUsrI+HzUPz9LBhdEpyc/UD9Y=;
	b=mTbL6Q6IKctprS6lMFjO6NwrY+B9OGAukBowuItbcMx1cZMN7/p4OqujaeL4K63H3O
	Y/xS1/MuiMljRcECUcYcyY5oilONEtrkc6QVjC0NGTjDiuUcBqhYrioSToSKUM2bUZgg
	ocnZRWFQCKIy+946sv7eQ8FoNTqU/3PZ3N6jq7eG55RtgUzzv/HaIaHmX5QbuEF7UtLg
	Q75uI4lHQ00qlQe7r62ackGJT/4mguknQzCdAMdII87LHOdIbo7vVuMPONt+3YJbjuPf
	WTVBHqxmgl/69db3amVtiz2Y6Zgbr58S/RZMUpcPLZEghWH6clmjjj4TMeP958VbF5Iv
	9Ltg==
References: <cover.1527641426.git.petrm@mellanox.com>
	<aa04e548376becfc699273d023dff0197ed97999.1527641426.git.petrm@mellanox.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <40c2c3fc-c892-69fa-9a9c-1a23d37ce28f@gmail.com>
Date: Tue, 29 May 2018 19:13:20 -0700
MIME-Version: 1.0
In-Reply-To: <aa04e548376becfc699273d023dff0197ed97999.1527641426.git.petrm@mellanox.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 5/8] dsa: port: Ignore bridge VLAN
	events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net, dan.carpenter@oracle.com



On 05/29/2018 05:59 PM, Petr Machata wrote:
> A follow-up patch enables emitting VLAN notifications for the bridge CPU
> port in addition to the existing slave port notifications. These
> notifications have orig_dev set to the bridge in question.
> 
> Because there's no specific support for these VLANs, just ignore the
> notifications to maintain the current behavior.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
