Return-Path: <sasak.1983@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=jal7m9A3itT+8ak1a2kolN1Aq19omAI7aOl0q7Ec92c=;
	b=WmBVShzt8kKGngS7WckygvTIiYNrGD8lNvDWlzpIMrM2sm3XBkwxLvEMOjsK4xcDpK
	KX2oYjRVoPupr9AnPlO/oB0yPI76fXokp1QCjqc21XcnSDNTGPLy8jLX1DPW3LkH9bq9
	MLrHr6MH2T4fIoQcFStikDmuFUuSMRzxqRNc7/L+drMq23aknKpzEkVVkZn6dCCenQhv
	VGFKcJPuvpUJNEbejqpZRbgNqIK77iI8oF8cyC6pW9loH33eoqxgdYGknzFIeqYsULVc
	G8fVLg/UGo6NbjQYw+dICyBjHBD+Ek7jVQXjPzzTewrEAL+kih/9NmsurwBMBUyJKVW9
	tJSg==
MIME-Version: 1.0
Date: Wed, 12 Sep 2012 15:07:47 +0530
Message-ID: <CANnGf_NDTZysXY8q5ccWH3NEHH_uQ4+cWK6FAap2r5c6yahu2A@mail.gmail.com>
From: Sasa Sasa <sasak.1983@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bridge]  Netlink message for bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

I have few questions regarding netlink messages sent by bridge to userspace.

1) Is there any provision for sending linkinfo type for bridge in the
RTM_NEWLINK message, when we add bridge. I mean, is there any
information associated with RTM_NEWLINK message that comes in
userspace to know that this interface is of BRIDGE type. Like for vlan
LINKINFO attribute contains the information..

2) Can we get net_bridge structures along with bridge_port etc ..
information via some netlink messages ? I know that port state change
info etc comes in RTM_NEWLINK but apart from that is there any
provision to get net_bridge structures?

Regards
Sandeep
