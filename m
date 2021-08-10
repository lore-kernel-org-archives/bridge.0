Return-Path: <dqfext@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=efM2azY1GAvdk/UvUuz5kJMAAN4U4q/U85YcIAgQ+ME=;
 b=lMw7+lN7Usqhku94n2XtHEsY/VysmPxQvlS/cwl7nBd3+UIkFC0TNiVyqq5g3ExNnv
 i7CGs6aKJboxrCIDWGYsB8bYdn2x7gcwGajHuAy4gzm4yFpwVMqh/QTcAXvhSgUL1F7M
 dMSjDrYuW7Z5e8W2Ai6Su1zoPp4FWLWAKtwLGq4x92fMNExfFh6hnCDJ4LofqUnJbl6G
 HIdYM4GjzPi4SAXU6UrF9LNXR1JY1ifTxjD6rm2vIeybNwS+GZ0AFhkBlVjICZx3pStU
 l4ao4yRaHQhjDfI801J3dLy4oEhDTLNkEfxauC1kBkbO+WCI0EZ0YeKzCt8WwKD5yZ7y
 T+OQ==
MIME-Version: 1.0
From: DENG Qingfang <dqfext@gmail.com>
Date: Tue, 10 Aug 2021 12:40:49 +0800
Message-ID: <CALW65jbotyW0MSOd-bd1TH_mkiBWhhRCQ29jgn+d12rXdj2pZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] Bridge port isolation offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Vladimir Oltean <olteanv@gmail.com>

Hi,

Bridge port isolation flag (BR_ISOLATED) was added in commit
7d850abd5f4e. But switchdev does not offload it currently.
It should be easy to implement in drivers, just like bridge offload
but prevent isolated ports to communicate with each other.

Your thoughts?

Regards,
  Qingfang
