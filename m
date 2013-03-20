Return-Path: <narayana.satya2001@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:date:message-id:subject:from:to:cc
	:content-type; bh=uDZWn6P1/Bh5bFukCx8FPxkEQX59DuVUeMzBYbgPf98=;
	b=s52uaSk+obAdcvtQgG2c1Yn9xN/2EkGjVK+XMzCg7nhbM56L3NYc3ENA8DTkeE+xPG
	qxCU8Kxj2Dsn+gshUJan3BEbtNSU0PCQuBEPng94wOfTlzIZyK3U9AbFcvD2Q2a8z6Yn
	URSWZE2wj0XS8olrLbNOCF9JJc7TGm4BbfiLWV2jvFkw48nfyQ7fl2wgLGkBatTI8mDo
	p2DMMHFMJiBG6RAkBRLZcOcKvm5xBrYJAWfiR4nzqW9Y/oG4VAuP0aPLNJzYJf8WAM8o
	q3qeyP94z1lrjAotKXOJzHN5ylv+estM17aj60dBCPf1E+m+4LyX70zi26UyVPUoIjwJ
	pW4Q==
MIME-Version: 1.0
Date: Wed, 20 Mar 2013 21:56:31 +0530
Message-ID: <CACAhnVhyVbDSYe8cvqLEUtQgxst4t-xP5i3X4KJkcETFRxNcJw@mail.gmail.com>
From: Satya Narayana <narayana.satya2001@gmail.com>
Content-Type: multipart/alternative; boundary=bcaec5523bb650c7ac04d85daf6a
Subject: [Bridge] [PATCH 2/2] bridge: Use IPv6 link-local address for
 multicast listener queries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--bcaec5523bb650c7ac04d85daf6a
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I am using 2.6.39.4 kernel for MLD snooping, in net/bridge/br_multicast.c
file,

we observed the check for tranoisent flag in the group address.

 That mean with out this flag set the group address will be droped.

 My doubt is why MLD is restricted with T (transient) flag, we can't use
with out T flag multicast group address.

 Looking forward for you replay, Thank you in advance.


Regards,

Satya

--bcaec5523bb650c7ac04d85daf6a
Content-Type: text/html; charset=ISO-8859-1

<p>Hello,</p><p>I am using 2.6.39.4 kernel for MLD snooping,  in net/bridge/br_multicast.c 
file, </p>
<p>we observed the check for tranoisent flag in the group address.</p>
<p> </p>
<p>That mean with out this flag set the group address will be droped.</p>
<p> </p>
<p>My doubt is why MLD is restricted with T (transient) flag, we can&#39;t use with 
out T flag multicast group address.</p>
<p> </p>
<p>Looking forward for you replay, Thank you in advance.</p>
<p><br> </p><p>Regards,</p><p>Satya<br></p>

--bcaec5523bb650c7ac04d85daf6a--
