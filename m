Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=to:from:subject:openpgp:autocrypt:cc:message-id:date:user-agent
	:mime-version:content-language:content-transfer-encoding;
	bh=cNkgLFgI3IYodLaZnBfPNlRKxbas84MDTDebT1Fs/YI=;
	b=MeCndNptMQB9TIXzCMyqNlKqYCRZY2q3Ho/e0q7OGquaDmL38NK8fTTpKCtCd/Kxrg
	scqebNaogi7x2IBhOQRnydaVg7gc4U2ZLtOQy2eGSfuRpJUep7TZ/wLu1ccFrvrIemuQ
	GjAe13U66bUCz+B08dj2WCDU+sgNNlvjzthzqcC7QQCN/bgwR3GJ2gXheMSJT1iTBpgd
	7CVGF9NRvNxcPRkIL+gq531VyW0suyTsJVFOTfyZhd52QbRpbbv/Nji/bXK77OL+FAO5
	QrXOLRvJu8GOVtrHnUBl+OsFo3A8LYkOtkrXi5Wz+yO7dFcB4EZcO3a7tekqTn5KF9L6
	eFsg==
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <61ecaa9f-f1ba-f79e-1d8b-4ec2eba5dc11@gmail.com>
Date: Tue, 11 Dec 2018 11:48:21 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Correct PVID behavior with bridge's VLAN filtering on/off?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com, idosch@mellanox.com
Cc: andrew@lunn.ch, vivien.didelot@gmail.com

Hi Nikolay, Roopa, Jiri, Ido,

When a bridge has vlan_filtering=0 and notifies a switch driver through
HOST_OBJ_MDB about MC addresses that the CPU/management port is
interested in getting MC traffic for, I am seeing that the mdb->vid is
set to 0 because br_allowed_ingress() checks for BROPT_VLAN_ENABLED
which is now disabled and so we never populated *vid to anything but 0
because the caller: br_handle_frame_finish() zeroed it out.

This creates a problem with the b53 DSA switch driver because in order
to match the bridge's default_pvid, we did program the switch's "default
tag" to be 1, which gets used for all untagged frames that ingress the
switch (which AFAICT is correct behavior for PVID).

Despite having turned off VLAN filtering in the switch such that it does
allow ingress of packets with a VID that is not present in the VLAN
table (violation), Multicast addresses do behave differently and we
really must be strictly matching the programmed PVID in order for MC
frames to ingress the switch even with VLAN filtering turned off.

So with all that being written, should the bridge still be sending MDB
notifications and use the bridge's default_pvid even with
vlan_filtering=0? And if we did that, what use case could we be possibly
breaking?

Let me know if this is not clear so I can provide mode details.

Thank you very much.
-- 
Florian
