Return-Path: <vyasevic@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Date: Wed, 26 Mar 2014 12:00:25 -0400
Message-Id: <1395849627-15711-2-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1395849627-15711-1-git-send-email-vyasevic@redhat.com>
References: <1395849627-15711-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [PATCH 0/2] bridge: Fix forwarding of 8021AD frames
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, shemminger@vyatta.com, bridge@lists.linux-foundation.org

Bridge has its own way to deterine if the packet is forwardable and it doesn't
support 8021ad tags correctly.  Instead just allow bridge to use an
existing is_skb_forwardable() function.

-vlad
