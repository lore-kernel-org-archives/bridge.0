DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
	bh=VV5V6CAiwzdj9E+ZPccm8xV1DfM3CAQP+IrtU+IWCrA=;
	b=jYFjAmfTrIx5DLYUKAig7uFfZvIiNopkmkrqHD6ccQi8f+TN/BcoCZZ5VYtm68j/MnAXK1yZ8GhI/WxNNgy/xyVXktZ02uAZyGu/TLmFprZB/GuMCRxedpZb3Xt5jZjj4GSz2LUHnRQsNPKATA3heezK5ATQpGljylvLEpZRYQg=
Message-ID: <7a95bc7b0710050842n7af1a1f7hcf0d8be91654f7e1@mail.gmail.com>
Date: Fri, 5 Oct 2007 11:42:19 -0400
From: glhs329@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] bridge-utils-1.2 doesn't include configure?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I downloaded bridge-utils-1.2.tar.gz (from
http://sourceforge.net/project/showfiles.php?group_id=26089), but it
doesn't include a ./configure script. Was this an oversight? Did I
miss something? I perused the mail list archive, and this
https://lists.linux-foundation.org/pipermail/bridge/2006-December/005187.html
post seems to suggest someone else may have encountered the problem.
